require 'rails_helper'

RSpec.describe "Api::V1::Votes::Resources::Votes", type: :request do
  before do
    @access_token = SecureRandom.hex
    FactoryBot.create :question, user_id: "c9242c5a-805b-4ef5-b3a7-2a7f25785cc8"
    @question = Question.last
    stub_find_user
  end
  

  describe "[POST] Endpoint /" do
    it "should success like" do
      post "/pendidikan_politik/v1/votes", headers: stub_auth_headers(@access_token),
        params: {id: @question.id, class_name: "Question"}
      expect(response.status).to eq(201)
      expect(json_response[:data][:vote][:status]).to eq(true)

      # vote again
      post "/pendidikan_politik/v1/votes", headers: stub_auth_headers(@access_token),
        params: {id: @question.id, class_name: "Question"}
      expect(response.status).to eq(201)
      expect(json_response[:data][:vote][:status]).to eq(false)

      get "/pendidikan_politik/v1/questions/#{@question.id}"
      expect(json_response[:data][:question][:like_count]).to eq(1)
    end

    it "should fail" do
      post "/pendidikan_politik/v1/votes", headers: stub_auth_headers(@access_token),
        params: {id: @question.id, class_name: "Questions"}
      expect(response.status).to eq(500)
    end

  end

  describe "[Delete] Endpoint /" do
    before do
      stub_find_user
    end
    it "should success unlike" do
      @user = User.find "1036fd3c-04ed-4949-b57c-b7dc8ff3e737"
      @question.liked_by @user
      delete "/pendidikan_politik/v1/votes", headers: stub_auth_headers(@access_token),
        params: {id: @question.id, class_name: "Question"}
      expect(response.status).to eq(200)
      expect(json_response[:data][:vote][:status]).to eq(true)

      # unvote again
      delete "/pendidikan_politik/v1/votes", headers: stub_auth_headers(@access_token),
        params: {id: @question.id, class_name: "Question"}
      expect(response.status).to eq(404)

      get "/pendidikan_politik/v1/questions/#{@question.id}"
      expect(json_response[:data][:question][:like_count]).to eq(0)
    end

  end

end