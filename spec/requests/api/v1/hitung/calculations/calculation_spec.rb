require "rails_helper"

RSpec.describe "Api::V1::Hitung::Calculation", type: :request do
  before do
    @access_token = SecureRandom.hex
    @hitung = FactoryBot.create :hitung_real_count, status: "published", user_id: "1036fd3c-04ed-4949-b57c-b7dc8ff3e737"
    @hitung2 = FactoryBot.create :hitung_real_count, status: "published", user_id: "c9242c5a-805b-4ef5-b3a7-2a7f25785cc8"
  end

  describe "Authorization" do
    it "authorized" do
      candidates = [
        {
          id: 1,
          total_vote: 100,
        },
        {
          id: 2,
          total_vote: 200,
        },
      ]
      response, json_response = build_calculation @hitung, "presiden", 10, candidates
      expect(response.status).to eq(200)
    end

    it "not authorized" do
      candidates = [
        {
          id: 1,
          total_vote: 100,
        },
        {
          id: 2,
          total_vote: 200,
        },
      ]
      response, json_response = build_calculation @hitung2, "presiden", 10, candidates
      expect(response.status).to eq(404)
    end
  end

  describe "[PUT] /hitung/v1/calculations" do
    context "when calculation_type is presiden & candidate id is not 1/2" do
      it "should return 422 and show message error " do
        candidates = [
          {
            id: 3,
            total_vote: 100,
          },
          {
            id: 4,
            total_vote: 200,
          },
        ]
        response, json_response = build_calculation @hitung, "presiden", 10, candidates
        expect(response.status).to eq(422)
        expect(json_response[:error][:errors][0]).to eq("ID Presiden = 1 atau 2")
      end
    end

    context "when calculation_type is not presiden & candidate is not in dapil" do
      before do
        FactoryBot.create(:province, id: 34)
        regency = FactoryBot.create(:regency)
        FactoryBot.create(:district)
        FactoryBot.create(:village)
        dapil = FactoryBot.create(:dapil, tingkat: 0, idWilayah: regency.id_wilayah)
        FactoryBot.create(:dapil_wilayah, idDapil: dapil.id, idWilayah: regency.id_wilayah)
        FactoryBot.create(:candidate, electoral_district_id: dapil.id)
        FactoryBot.create(:candidate, electoral_district_id: dapil.id)
      end
      it "should return 422" do
        candidates = [
          {
            id: 3,
            total_vote: 100,
          },
          {
            id: 4,
            total_vote: 200,
          },
        ]
        response, json_response = build_calculation @hitung, "dpr", 10, candidates
        expect(response.status).to eq(422)
      end
    end

    context "when calculation_type is not presiden & candidate is in dapil" do
      before do
        FactoryBot.create(:province, id: 34)
        regency = FactoryBot.create(:regency)
        FactoryBot.create(:district)
        FactoryBot.create(:village)
        dapil = FactoryBot.create(:dapil, tingkat: 1, idWilayah: regency.id_wilayah)
        FactoryBot.create(:dapil_wilayah, idDapil: dapil.id, idWilayah: regency.id_wilayah)
        @candidate1 = FactoryBot.create(:candidate, electoral_district_id: dapil.id)
        @candidate2 = FactoryBot.create(:candidate, electoral_district_id: dapil.id)
      end
      it "should return 200" do
        candidates = [
          {
            id: @candidate1.id,
            total_vote: 100,
          },
          {
            id: @candidate2.id,
            total_vote: 200,
          },
        ]
        response, json_response = build_calculation @hitung, "provinsi", 10, candidates
        expect(response.status).to eq(200)
      end
    end

  end

  def build_calculation(hitung, calculation_type, invalid_vote, candidates, parties = nil)
    p = {
      hitung_real_count_id: hitung.id,
      calculation_type: calculation_type,
      invalid_vote: invalid_vote,
      candidates: candidates,
    }
    p[:parties] = parties if parties.present?
    put "/hitung/v1/calculations/", headers: stub_auth_headers(@access_token),
                                  params: p
    [response, json_response]
  end
end
