require 'rails_helper'

RSpec.describe "Api::V1::Hitung::RealCounts", type: :request do
  describe "Create real count" do
    before do
      populate_region
    end
    it "Success create" do
      access_token = SecureRandom.hex
      post "/hitung/v1/real_counts", headers: stub_auth_headers(access_token),
        params: {
          tps: 1,
          province_code: 92,
          regency_code: 9271,
          district_code: 927110,
          village_code: 9271101004,
          latitude: -7.7367346,
          longitude: 110.3962141
        }
      expect(response.status).to eq(201)
      expect(json_response[:data][:status]).to eq(true)
      expect(json_response[:data][:real_count][:status]).to eq("draft")
    end
  end

  describe "Modify status" do
    before do
      @id = FactoryBot.create(:hitung_real_count).id
    end

    it "published!" do
      access_token = SecureRandom.hex
      post "/hitung/v1/real_counts/#{@id}/publish", headers: stub_auth_headers(access_token)

      expect(response.status).to eq(201)
      expect(json_response[:data][:status]).to eq(true)
      expect(json_response[:data][:real_count][:status]).to eq("published")
    end

    it "draft!" do
      access_token = SecureRandom.hex
      post "/hitung/v1/real_counts/#{@id}/draft", headers: stub_auth_headers(access_token)

      expect(response.status).to eq(201)
      expect(json_response[:data][:status]).to eq(true)
      expect(json_response[:data][:real_count][:status]).to eq("draft")
    end
  end
end
