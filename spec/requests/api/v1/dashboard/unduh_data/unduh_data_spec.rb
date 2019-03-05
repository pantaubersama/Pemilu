require "rails_helper"

RSpec.describe "API::V1::Dashboard::UnduhData", type: :request do
  before do
    @access_token = SecureRandom.hex
  end
  let(:request_unduh_data) { FactoryBot.create(:request_datum) }

  describe "[GET] /dashboard/v1/unduh_data/list_request" do
    it "should return 200 and list request unduh data" do
      get "/dashboard/v1/unduh_data/list_request", headers:stub_admin_auth_headers(@access_token)
      expect(response.status).to eq(200)
    end
  end

  describe "[GET] /dashboard/v1/unduh_data/request/:id" do
    it "should return 200 " do
      get "/dashboard/v1/unduh_data/request/#{request_unduh_data.id}", headers: stub_admin_auth_headers(@access_token)
      expect(response.status).to eq(200)
    end
  end

end
