require 'rails_helper'

RSpec.describe "Api::V1::LiniMasa::Resources::Feeds", type: :request do
  before do
    @access_token = SecureRandom.hex
  end

  describe "empty record" do
    it "has no error" do
      get "/linimasa/v1/feeds/pilpres", headers: stub_auth_headers(@access_token),
        params: {page: 1, per_page: 5}
      expect(response.status).to eq(200)
    end
  end
end