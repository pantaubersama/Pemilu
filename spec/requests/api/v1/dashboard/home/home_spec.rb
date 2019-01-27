require 'rails_helper'

RSpec.describe "Api::V1::Dashboard::Home", type: :request do
  before do
    @access_token = SecureRandom.hex
    stub_find_user
    stub_user_model
  end
  
  describe "statistics" do
    it "success" do
      get "/dashboard/v1/home/statistics", headers: stub_admin_auth_headers(@access_token)
      expect(response.status).to eq(200)
    end
  end

  describe "question graph" do
    it "success" do
      get "/dashboard/v1/home/questions", headers: stub_admin_auth_headers(@access_token)
      expect(response.status).to eq(200)
    end
  end

  describe "report graph" do
    it "success" do
      get "/dashboard/v1/home/reports", headers: stub_admin_auth_headers(@access_token)
      expect(response.status).to eq(200)
    end
  end

end
