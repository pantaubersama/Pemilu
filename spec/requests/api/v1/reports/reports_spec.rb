require 'rails_helper'

RSpec.describe "Api::V1::Reports::Resources::Reports", type: :request do
  before do
    @access_token = SecureRandom.hex
    FactoryBot.create :question
    @question = Question.last
  end
  

  describe "[POST] Endpoint /" do
    it "should success like" do
      post "/pendidikan_politik/v1/reports", headers: auth_headers(@access_token), 
        params: {id: @question.id, class_name: "Question"}
      expect(response.status).to eq(201)
      expect(json_response[:data][:vote][:status]).to eq(true)

      # report again
      post "/pendidikan_politik/v1/reports", headers: auth_headers(@access_token), 
        params: {id: @question.id, class_name: "Question"}
      expect(response.status).to eq(201)
      expect(json_response[:data][:vote][:status]).to eq(false)
    end

    it "should fail" do
      post "/pendidikan_politik/v1/reports", headers: auth_headers(@access_token), 
        params: {id: @question.id, class_name: "Questions"}
      expect(response.status).to eq(500)
    end

  end

end