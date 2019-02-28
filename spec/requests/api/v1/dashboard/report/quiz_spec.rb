require 'rails_helper'

RSpec.describe "Api::V1::Dashboard::Report::Quiz", type: :request do
  before do
    @access_token = SecureRandom.hex
    @access_token_2 = SecureRandom.hex
    random_quiz(3)
    random_quiz(4)
    @quiz_1 = Quiz.first
    @quiz_2 = Quiz.last
  end

  describe "Authorized" do
    it "authorized" do
      get "/dashboard/v1/report/per_questions", headers: stub_admin_auth_headers(@access_token)
      expect(response.status).to eq(200)
    end
    it "not authorized" do
      get "/dashboard/v1/report/per_questions", headers: stub_not_authorized_headers(@access_token_2)
      expect(response.status).to eq(403)
    end
  end

  describe "Per question" do
    it "have correct values" do
      simulate_quiz
      get "/dashboard/v1/report/per_questions", headers: stub_admin_auth_headers(@access_token)
      expect(json_response["data"].size).to eq(7)
      json_response["data"].each_with_index do |d, i|
        expect(json_response["data"][i]["teams"][0]["percentage"] + json_response["data"][i]["teams"][1]["percentage"]).to eq(100.00)
      end

      get "/dashboard/v1/report/per_questions", headers: stub_admin_auth_headers(@access_token),
        params: {
          quiz_id: @quiz_2.id
        }
      expect(json_response["data"].size).to eq(4)
      json_response["data"].each_with_index do |d, i|
        expect(json_response["data"][i]["teams"][0]["percentage"] + json_response["data"][i]["teams"][1]["percentage"]).to eq(100.00)
      end
    end
  end

  def simulate_quiz
    get "/pendidikan_politik/v1/quizzes/#{@quiz_1.id}/questions", headers: stub_auth_headers(@access_token_2)
    question1 = json_response[:data][:questions][0][:id]
    answer1   = json_response[:data][:questions][0][:answers].last[:id]
    question2 = json_response[:data][:questions][1][:id]
    answer2   = json_response[:data][:questions][1][:answers].last[:id]
    question3 = json_response[:data][:questions][2][:id]
    answer3   = json_response[:data][:questions][2][:answers].last[:id]
    post "/pendidikan_politik/v1/quizzes/#{@quiz_1.id}/questions", headers: stub_auth_headers(@access_token_2), params: { question_id: question1, answer_id: answer1 }
    post "/pendidikan_politik/v1/quizzes/#{@quiz_1.id}/questions", headers: stub_auth_headers(@access_token_2), params: { question_id: question2, answer_id: answer2 }
    post "/pendidikan_politik/v1/quizzes/#{@quiz_1.id}/questions", headers: stub_auth_headers(@access_token_2), params: { question_id: question3, answer_id: answer3 }

    get "/pendidikan_politik/v1/quizzes/#{@quiz_2.id}/questions", headers: stub_auth_headers(@access_token_2)
    question1 = json_response[:data][:questions][0][:id]
    answer1   = json_response[:data][:questions][0][:answers].last[:id]
    question2 = json_response[:data][:questions][1][:id]
    answer2   = json_response[:data][:questions][1][:answers].last[:id]
    question3 = json_response[:data][:questions][2][:id]
    answer3   = json_response[:data][:questions][2][:answers].last[:id]
    question4 = json_response[:data][:questions][3][:id]
    answer4   = json_response[:data][:questions][3][:answers].last[:id]
    post "/pendidikan_politik/v1/quizzes/#{@quiz_2.id}/questions", headers: stub_auth_headers(@access_token_2), params: { question_id: question1, answer_id: answer1 }
    post "/pendidikan_politik/v1/quizzes/#{@quiz_2.id}/questions", headers: stub_auth_headers(@access_token_2), params: { question_id: question2, answer_id: answer2 }
    post "/pendidikan_politik/v1/quizzes/#{@quiz_2.id}/questions", headers: stub_auth_headers(@access_token_2), params: { question_id: question3, answer_id: answer3 }
    post "/pendidikan_politik/v1/quizzes/#{@quiz_2.id}/questions", headers: stub_auth_headers(@access_token_2), params: { question_id: question4, answer_id: answer4 }
  end

end
