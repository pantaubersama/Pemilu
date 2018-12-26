require 'rails_helper'

RSpec.describe "Api::V1::Linimasa::JanjiPolitiks", type: :request do
  before do
    @access_token = SecureRandom.hex
    stub_auth_token(@access_token)
  end
  describe "[GET] Endpoint /janji_politiks" do
    before do
      # params: { avatar: fixture_file_upload('files/avatar.jpg', 'image/jpg') }
      create :janji_politik, title: "Pengadaan Bunker Anti Bencana", body: "Pada 2019, di wacanakan bunker anti bencana siap di resmikan."
    end
    it "should returns 200 with valid params when success" do
      get "/linimasa/v1/janji_politiks", headers: auth_headers(@access_token)
      expect(json_response[:data][:janji_politiks].size).to eq(1)
      expect(json_response[:data][:janji_politiks].first[:body]).to eq("Pada 2019, di wacanakan bunker anti bencana siap di resmikan.")
      expect(json_response[:data][:janji_politiks].first[:title]).to eq("Pengadaan Bunker Anti Bencana")
      expect(json_response[:data][:janji_politiks]).to eq("1036fd3c-04ed-4949-b57c-b7dc8ff3e737")
      expect(json_response[:data][:janji_politiks].first[:user][:email]).to eq("namakukingkong@gmail.com")
      expect(json_response[:data][:janji_politiks].first[:user][:first_name]).to eq("Joan")
      expect(json_response[:data][:janji_politiks].first[:user][:last_name]).to eq("Weeks")
      expect(response.status).to eq(200)
    end
  end
end

#client_credentials
#
