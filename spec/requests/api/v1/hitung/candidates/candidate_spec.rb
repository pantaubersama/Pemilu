require "rails_helper"

RSpec.describe "API::V1::Hitung::Candidates", type: :request do
  let(:dapil) { FactoryBot.create(:dapil) }
  let(:political_party) { FactoryBot.create(:political_party) }
  let(:caleg) { FactoryBot.create(:candidate) }

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
        political_party = FactoryBot.create(:political_party)
        FactoryBot.create(:candidate, electoral_district_id: dapil.id, political_party_id: political_party.id)
        FactoryBot.create(:candidate, electoral_district_id: dapil.id, political_party_id: political_party.id)
        FactoryBot.create(:candidate, electoral_district_id: dapil.id, political_party_id: political_party.id)
        get "/hitung/v1/candidates", params: {
          dapil_id: dapil.id,
          political_party_id: political_party.id,
          tingkat: "dpr"
        }
        expect(response.status).to eq(200)
        expect(json_response[:data][:candidates].size).to eq(3)
        expect(json_response[:data][:candidates][0][:political_party_id]).to eq(political_party.id)
        expect(json_response[:data][:candidates][1][:political_party_id]).to eq(political_party.id)
        expect(json_response[:data][:candidates][2][:political_party_id]).to eq(political_party.id)
        expect(json_response[:data][:candidates][0][:electoral_district_id]).to eq(dapil.id)
        expect(json_response[:data][:candidates][1][:electoral_district_id]).to eq(dapil.id)
        expect(json_response[:data][:candidates][2][:electoral_district_id]).to eq(dapil.id)
      end
    end

    describe "Provinsi" do
      it "should return 200 and list Provinsi Caleg by Political Party" do
        dapil = FactoryBot.create(:dapil, tingkat: 1)
        political_party = FactoryBot.create(:political_party)
        FactoryBot.create(:candidate, electoral_district_id: dapil.id, political_party_id: political_party.id)
        FactoryBot.create(:candidate, electoral_district_id: dapil.id, political_party_id: political_party.id)
        FactoryBot.create(:candidate, electoral_district_id: dapil.id, political_party_id: political_party.id)
        get "/hitung/v1/candidates", params: {
          dapil_id: dapil.id,
          political_party_id: political_party.id,
          tingkat: "provinsi"
        }
        expect(response.status).to eq(200)
        expect(json_response[:data][:candidates].size).to eq(3)
        expect(json_response[:data][:candidates][0][:political_party_id]).to eq(political_party.id)
        expect(json_response[:data][:candidates][1][:political_party_id]).to eq(political_party.id)
        expect(json_response[:data][:candidates][2][:political_party_id]).to eq(political_party.id)
        expect(json_response[:data][:candidates][0][:electoral_district_id]).to eq(dapil.id)
        expect(json_response[:data][:candidates][1][:electoral_district_id]).to eq(dapil.id)
        expect(json_response[:data][:candidates][2][:electoral_district_id]).to eq(dapil.id)
      end
    end

    describe "Kabupaten" do
      it "should return 200 and list Kabupaten Caleg by Political Party" do
        dapil = FactoryBot.create(:dapil, tingkat: 2)
        political_party = FactoryBot.create(:political_party)
        FactoryBot.create(:candidate, electoral_district_id: dapil.id, political_party_id: political_party.id)
        FactoryBot.create(:candidate, electoral_district_id: dapil.id, political_party_id: political_party.id)
        FactoryBot.create(:candidate, electoral_district_id: dapil.id, political_party_id: political_party.id)
        get "/hitung/v1/candidates", params: {
          dapil_id: dapil.id,
          political_party_id: political_party.id,
          tingkat: "kabupaten"
        }
        expect(response.status).to eq(200)
        expect(json_response[:data][:candidates].size).to eq(3)
        expect(json_response[:data][:candidates][0][:political_party_id]).to eq(political_party.id)
        expect(json_response[:data][:candidates][1][:political_party_id]).to eq(political_party.id)
        expect(json_response[:data][:candidates][2][:political_party_id]).to eq(political_party.id)
        expect(json_response[:data][:candidates][0][:electoral_district_id]).to eq(dapil.id)
        expect(json_response[:data][:candidates][1][:electoral_district_id]).to eq(dapil.id)
        expect(json_response[:data][:candidates][2][:electoral_district_id]).to eq(dapil.id)
      end
    end


  end
end
