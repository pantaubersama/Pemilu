require "rails_helper"

RSpec.describe "API::V1::Hitung::Candidates", type: :request do

  describe "[GET] /hitung/v1/candidates" do
    it "should return 200" do
      get "/hitung/v1/candidates", params: {
        dapil_id: 1,
        tingkat: "dpr"
      }
      expect(response.status).to eq(200)
    end

    describe "DPD" do
      it "should return 200 and list DPD Caleg" do
        dapil = FactoryBot.create(:dapil, tingkat: 3)
        populate_candidate dapil
        get "/hitung/v1/candidates", params: {
          dapil_id: dapil.id,
          tingkat: "dpd"
        }
        expect(response.status).to eq(200)
      end
    end

    describe "DPR" do
      it "should return 200 and list DPR Caleg by Political Party" do
        dapil = FactoryBot.create(:dapil, tingkat: 0)
        populate_candidate dapil
        get "/hitung/v1/candidates", params: {
          dapil_id: dapil.id,
          tingkat: "dpr"
        }
        expect(response.status).to eq(200)
      end
    end

    describe "Provinsi" do
      it "should return 200 and list Provinsi Caleg by Political Party" do
        dapil = FactoryBot.create(:dapil, tingkat: 1)
        populate_candidate dapil
        get "/hitung/v1/candidates", params: {
          dapil_id: dapil.id,
          tingkat: "provinsi"
        }
        expect(response.status).to eq(200)
      end
    end

    describe "Kabupaten" do
      it "should return 200 and list Kabupaten Caleg by Political Party" do
        dapil = FactoryBot.create(:dapil, tingkat: 2)
        populate_candidate dapil
        get "/hitung/v1/candidates", params: {
          dapil_id: dapil.id,
          tingkat: "kabupaten"
        }
        expect(response.status).to eq(200)
      end
    end

    def populate_candidate dapil
      FactoryBot.create(:dapil)
      FactoryBot.create(:political_party)
      FactoryBot.create(:candidate, electoral_district_id: dapil.id)
      FactoryBot.create(:candidate, electoral_district_id: dapil.id)
      FactoryBot.create(:candidate, electoral_district_id: dapil.id)
    end
  end
end
