require 'rails_helper'

RSpec.describe "Api::V1::Linimasa::JanjiPolitiks", type: :request do
  before do
    stub_find_user_2
  end
  describe "[GET] Endpoint /janji_politiks" do
    before do
      create :janji_politik, title: "Pengadaan Bunker Anti Bencana", body: "Pada 2019, di wacanakan bunker anti bencana siap di resmikan."
    end
    it "should returns 200 with valid params when success" do
      get "/linimasa/v1/janji_politiks", headers: stub_auth_headers(@access_token)
      expect(json_response[:data][:janji_politiks].size).to eq(1)
      expect(json_response[:data][:janji_politiks].first[:body]).to eq("Pada 2019, di wacanakan bunker anti bencana siap di resmikan.")
      expect(json_response[:data][:janji_politiks].first[:title]).to eq("Pengadaan Bunker Anti Bencana")
      expect(json_response[:data][:janji_politiks].first[:user][:id]).to eq("1036fd3c-04ed-4949-b57c-b7dc8ff3e737")
      expect(json_response[:data][:janji_politiks].first[:user][:email]).to eq("namakukingkong@gmail.com")
      expect(json_response[:data][:janji_politiks].first[:user][:first_name]).to eq("Joan")
      expect(json_response[:data][:janji_politiks].first[:user][:last_name]).to eq("Weeks")
      expect(response.status).to eq(200)
    end
  end
  describe "[POST] Endpoint /janji_politiks" do
    it "should returns 201 with valid params when success" do
      post "/linimasa/v1/janji_politiks",
           params:  {
               title: "Berbagi nasi bungkus bersama rakyat.",
               body: "Tak ayal apapun dilakukan",
               image: fixture_file_upload('files/janji_image.jpg', 'image/jpg')
           },
           headers: stub_eligible_auth_headers
      expect(json_response[:data][:janji_politik][:title]).to eq("Berbagi nasi bungkus bersama rakyat.")
      expect(json_response[:data][:janji_politik][:body]).to eq("Tak ayal apapun dilakukan")
      expect(response.status).to eq(201)
    end
  end
end
