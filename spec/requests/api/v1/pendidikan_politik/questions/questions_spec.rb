require 'rails_helper'

RSpec.describe "Api::V1::PendidikanPolitik::Question", type: :request do
  before do
    @access_token = SecureRandom.hex
    FactoryBot.create :question
    FactoryBot.create :question
  end
  
  describe "[POST] Endpoint /" do
    it "should returns 201 with valid params when success" do
      post "/pendidikan_politik/v1/questions", headers: auth_headers(@access_token), 
        params: {body: "Apakah harga premium akan disubsidi pemerintah?"}
      expect(response.status).to eq(201)
      expect(json_response[:data][:status]).to eq(true)
    end
  end

  describe "[GET] Endpoint /:id" do
    it "should return 200 with valid ID" do
      q = Question.last
      get "/pendidikan_politik/v1/questions/#{q.id}", headers: auth_headers(@access_token)
      expect(response.status).to eq(200)
      expect(json_response[:data][:question][:id]).to eq(q.id)
    end
  end
  
end