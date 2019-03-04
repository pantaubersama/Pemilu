require "rails_helper"

RSpec.describe "API::V1::Hitung::Candidates", type: :request do

  describe "[GET] /hitung/v1/candidates" do
    it "should return 200" do
      get "/hitung/v1/candidates", params: {
        dapil_id: 1,
        political_party_id: 1,
        tingkat: "dpr"
      }
      expect(response.status).to eq(200)
    end

    describe "DPD" do
      it "should return 200 and list DPD Caleg" do
        dapil = FactoryBot.create(:dapil, tingkat: 3)
        FactoryBot.create(:candidate, electoral_district_id: dapil.id)
        FactoryBot.create(:candidate, electoral_district_id: dapil.id)
        get "/hitung/v1/candidates", params: {
          dapil_id: dapil.id,
          tingkat: "dpd"
        }
        expect(response.status).to eq(200)
        expect(json_response[:data][:candidates].size).to eq(2)
      end
    end

    describe "DPR" do
      it "should return 200 and list DPR Caleg by Political Party" do
        dapil = FactoryBot.create(:dapil, tingkat: 0)
        FactoryBot.create(:candidate, electoral_district_id: dapil.id)
        FactoryBot.create(:candidate, electoral_district_id: dapil.id)
        FactoryBot.create(:candidate, electoral_district_id: dapil.id)
        get "/hitung/v1/candidates", params: {
          dapil_id: dapil.id,
          tingkat: "dpr"
        }
        expect(response.status).to eq(200)
        expect(json_response[:data][:candidates].size).to eq(3)
        expect(json_response[:data][:candidates][0][:electoral_district_id]).to eq(dapil.id)
        expect(json_response[:data][:candidates][1][:electoral_district_id]).to eq(dapil.id)
        expect(json_response[:data][:candidates][2][:electoral_district_id]).to eq(dapil.id)
      end
    end

    describe "Provinsi" do
      it "should return 200 and list Provinsi Caleg by Political Party" do
        dapil = FactoryBot.create(:dapil, tingkat: 1)
        FactoryBot.create(:candidate, electoral_district_id: dapil.id)
        FactoryBot.create(:candidate, electoral_district_id: dapil.id)
        FactoryBot.create(:candidate, electoral_district_id: dapil.id)
        get "/hitung/v1/candidates", params: {
          dapil_id: dapil.id,
          tingkat: "provinsi"
        }
        expect(response.status).to eq(200)
        expect(json_response[:data][:candidates].size).to eq(3)
        expect(json_response[:data][:candidates][0][:electoral_district_id]).to eq(dapil.id)
        expect(json_response[:data][:candidates][1][:electoral_district_id]).to eq(dapil.id)
        expect(json_response[:data][:candidates][2][:electoral_district_id]).to eq(dapil.id)
      end
    end

    describe "Kabupaten" do
      it "should return 200 and list Kabupaten Caleg by Political Party" do
        dapil = FactoryBot.create(:dapil, tingkat: 2)
        FactoryBot.create(:candidate, electoral_district_id: dapil.id)
        FactoryBot.create(:candidate, electoral_district_id: dapil.id)
        FactoryBot.create(:candidate, electoral_district_id: dapil.id)
        get "/hitung/v1/candidates", params: {
          dapil_id: dapil.id,
          tingkat: "kabupaten"
        }
        expect(response.status).to eq(200)
        expect(json_response[:data][:candidates].size).to eq(3)
        expect(json_response[:data][:candidates][0][:electoral_district_id]).to eq(dapil.id)
        expect(json_response[:data][:candidates][1][:electoral_district_id]).to eq(dapil.id)
        expect(json_response[:data][:candidates][2][:electoral_district_id]).to eq(dapil.id)
      end
    end


  end
end
