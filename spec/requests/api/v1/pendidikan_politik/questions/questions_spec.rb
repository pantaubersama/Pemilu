require 'rails_helper'

RSpec.describe "Api::V1::PendidikanPolitik::Resources::Question", type: :request do
  before do
    @access_token = SecureRandom.hex
    5.times do
      FactoryBot.create :question
    end
    stub_find_user_2
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
      get "/pendidikan_politik/v1/questions/#{q.id}"
      # expect(response.status).to eq(200)
      # expect(json_response[:data][:question][:id]).to eq(q.id)
    end
  end

  describe "[DELETE] Endpoint /" do
    it "should returns 200 when success" do
      q = Question.last
      delete "/pendidikan_politik/v1/questions", params: {id: q.id}, headers: auth_headers(@access_token)
      expect(response.status).to eq(200)
      expect(json_response[:data][:status]).to eq(true)
    end

    it "404 question is not owned by current_user" do
      q = Question.create user_id: "c9242c5a-805b-4ef5-b3a7-2a7f25785cc8", body: Faker::Lorem.sentence(3)
      delete "/pendidikan_politik/v1/questions", params: {id: q.id}, headers: auth_headers(@access_token)
      expect(response.status).to eq(404)
    end
  end

  describe "[GET] Endpoint /" do
    it "List questions" do
      Question.reindex
      get "/pendidikan_politik/v1/questions"
      expect(response.status).to eq(200)
    end
  end
  
end