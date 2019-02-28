require 'rails_helper'

RSpec.describe "Api::V1::Hitung::RealCounts", type: :request do
  before do
    @id = FactoryBot.create(:hitung_real_count, status: "published", user_id: "1036fd3c-04ed-4949-b57c-b7dc8ff3e737").id
  end

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

  describe "show real count" do
    it "success display" do
      get "/hitung/v1/real_counts/#{@id}"
      expect(response.status).to eq(200)
      expect(json_response[:data][:real_count][:id]).to eq(@id)
    end
  end

  describe "List real count" do
    it "success display" do
      get "/hitung/v1/real_counts/"
      expect(response.status).to eq(200)
      expect(json_response[:data][:real_counts].size).to eq(1)
    end
  end

  describe "List real count by user" do
    it "success display" do
      get "/hitung/v1/real_counts/", params: {
        user_id: "1036fd3c-04ed-4949-b57c-b7dc8ff3e737"
      }
      expect(response.status).to eq(200)
      expect(json_response[:data][:real_counts].size).to eq(1)
    end
  end

  describe "edit real count" do
    it "success edit" do
      access_token = SecureRandom.hex
      put "/hitung/v1/real_counts/#{@id}", params: {
        tps: 2
      }, headers: stub_auth_headers(access_token)
      expect(response.status).to eq(200)
      expect(json_response[:data][:status]).to eq(true)
      expect(json_response[:data][:real_count][:tps]).to eq(2)
    end
  end

  describe "destroy real count" do
    it "success destroy" do
      access_token = SecureRandom.hex
      delete "/hitung/v1/real_counts/#{@id}", params: {
        tps: 2
      }, headers: stub_auth_headers(access_token)
      expect(response.status).to eq(200)
      expect(json_response[:data][:status]).to eq(true)
    end
  end

  describe "Modify status" do
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
