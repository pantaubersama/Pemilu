require 'rails_helper'

RSpec.describe "Api::V1::PendidikanPolitik::Question", type: :request do
  describe "[POST] Endpoint /" do
    it "should returns 201 with valid params when success" do
      access_token = SecureRandom.hex
      post "/pendidikan_politik/v1/questions", headers: auth_headers(access_token), 
        params: {body: "Apakah harga premium akan disubsidi pemerintah?"}
      expect(response.status).to eq(201)
      expect(json_response[:data][:status]).to eq(true)
    end
  end
end