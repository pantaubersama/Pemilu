require 'rails_helper'

RSpec.describe "Api::V1::Hitung::Infos", type: :request do
  describe "[GET] Endpoint /infos/test" do
    it "should returns 200 with valid params when success" do
      access_token = SecureRandom.hex
      get "/hitung/v1/infos/test", headers: stub_auth_headers(access_token)
      expect(response.status).to eq(200)
      expect(json_response[:data][:current_user_id]).to eq("1036fd3c-04ed-4949-b57c-b7dc8ff3e737")
      expect(json_response[:data][:full_token][:access_token]).to eq(access_token)
    end
  end
end