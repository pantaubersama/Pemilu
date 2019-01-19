require 'rails_helper'

RSpec.describe "Api::V1::Linimasa::Kenalans", type: :request do
  describe "[GET] Endpoint /kenalans" do
    it "should returns 200 with valid params when success" do
      get "/linimasa/v1/kenalans", headers: stub_auth_headers
      expect(json_response[:data][:kenalans].pluck("is_action")).to eq([false, false, false, false, false, false, false, false, false, false])
      expect(response.status).to eq(200)
    end
    it "should returns 200 with valid params when success" do
      create :user_kenalan, user_id: "1036fd3c-04ed-4949-b57c-b7dc8ff3e737", kenalan_id: "c46bae56-8c87-4f54-8328-b959d89c931f"
      get "/linimasa/v1/kenalans", headers: stub_auth_headers
      expect(json_response[:data][:kenalans].pluck("is_action")).to eq([true, false, false, false, false, false, false, false, false, false])
      expect(response.status).to eq(200)
    end
  end
  describe "[PUT] Endpoint /kenalans" do
    it "should returns 200 with valid params when success" do
      put "/linimasa/v1/kenalans", params: {id: "9bbc974c-dab4-4467-ac5f-84e8a8d56b1c"} ,headers: stub_auth_headers
      expect(json_response[:data][:kenalans].pluck("is_action")).to eq([false, true, false, false, false, false, false, false, false, false])
      expect(response.status).to eq(200)
    end
  end
end
