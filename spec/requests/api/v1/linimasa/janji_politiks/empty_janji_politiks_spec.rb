require 'rails_helper'

RSpec.describe "Api::V1::LiniMasa::Resources::JanjiPolitik", type: :request do
  before do
    @access_token = SecureRandom.hex
  end

  describe "empty record" do
    it "has no error" do
      JanjiPolitik.reindex
      get "/linimasa/v1/janji_politiks", headers: stub_auth_headers(@access_token),
        params: {page: 1, per_page: 5}
      expect(response.status).to eq(200)
      expect(json_response[:data][:janji_politiks].size).to eq(0)
    end
  end
end