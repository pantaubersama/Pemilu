require 'rails_helper'

RSpec.describe "Api::V1::PendidikanPolitik::Resources::Examples", type: :request do
  before do
    @access_token = SecureRandom.hex(32)
  end

  describe "[GET] Public endpoint /public" do
    it "success" do
      get "/pendidikan_politik/v1/examples/public"
      expect(response.status).to eq(200)
      expect(json_response[:data][:current_user]).to eq(nil)
    end
  end

  describe "[GET] Optional endpoint /optional" do
    it "success with access token" do
      get "/pendidikan_politik/v1/examples/optional", headers: stub_auth_headers(@access_token)
      expect(response.status).to eq(200)
      expect(json_response[:data][:current_user]).not_to eq(nil)
    end

    it "success without access token" do
      get "/pendidikan_politik/v1/examples/optional"
      expect(response.status).to eq(200)
      expect(json_response[:data][:current_user]).to eq(nil)
    end
  end

  describe "[GET] Protected endpoint /protected" do
    it "success with access token" do
      get "/pendidikan_politik/v1/examples/protected", headers: stub_auth_headers(@access_token)
      expect(response.status).to eq(200)
      expect(json_response[:data][:current_user]).not_to eq(nil)
    end

    it "fail without access token" do
      get "/pendidikan_politik/v1/examples/protected"
      expect(response.status).to eq(401)
    end
  end
  
end