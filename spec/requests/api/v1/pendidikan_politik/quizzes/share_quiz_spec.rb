require 'rails_helper'

RSpec.describe "Api::V1::PendidikanPolitik::Resources::QuizParticipations", type: :request do
  before do
    @access_token = SecureRandom.hex(32)
    stub_find_user
  end

  describe "Share" do
    before do
      post "/pendidikan_politik/v1/only_staging/generate_random_quiz", params: {total_question: 3}

      @quiz = Quiz.first

      get "/pendidikan_politik/v1/quizzes/#{@quiz.id}", headers: stub_auth_headers(@access_token)
      get "/pendidikan_politik/v1/quizzes/#{@quiz.id}/questions", headers: stub_auth_headers(@access_token)

      @quiz_participation_id = json_response[:data][:quiz_participation][:id]
      
      question0 = json_response[:data][:questions][0][:id]
      answer0 = json_response[:data][:questions][0][:answers].last[:id]

      question1 = json_response[:data][:questions][1][:id]
      answer1 = json_response[:data][:questions][1][:answers].last[:id]

      question2 = json_response[:data][:questions][2][:id]
      answer2 = json_response[:data][:questions][2][:answers].last[:id]

      post "/pendidikan_politik/v1/quizzes/#{@quiz.id}/questions", headers: stub_auth_headers(@access_token), params: {question_id: question0, answer_id: answer0}
      post "/pendidikan_politik/v1/quizzes/#{@quiz.id}/questions", headers: stub_auth_headers(@access_token), params: {question_id: question1, answer_id: answer1}
      post "/pendidikan_politik/v1/quizzes/#{@quiz.id}/questions", headers: stub_auth_headers(@access_token), params: {question_id: question2, answer_id: answer2}
    end

    it "User Quiz result" do
      get "/pendidikan_politik/v1/quiz_participations/#{@quiz_participation_id}/result"
      expect(json_response[:data][:answers].size).to eq(0) # tidak menampilkan jawaban saat share
      expect(json_response[:data][:teams].size).to eq(2)
      expect(json_response[:data][:teams][0][:percentage]).to be >= 0.0
      expect(json_response[:data][:teams][1][:percentage]).to be >= 0.0

      expect(json_response[:data][:user][:id]).to eq("1036fd3c-04ed-4949-b57c-b7dc8ff3e737")
      expect(json_response[:data][:quiz_participation][:id]).not_to eq(nil)
      expect(json_response[:data][:quiz][:id]).to eq(@quiz.id)
      expect(json_response[:data][:quiz][:title]).to eq(@quiz.title)

      expect(json_response[:data][:teams][0][:team]).to eq(
        {"avatar"=>"https://s3-ap-southeast-1.amazonaws.com/pantau-test/assets/teams/avatar_team_1.png", "id"=>1, "title"=>"Jokowi - Ma'ruf"}
      )
      expect(json_response[:data][:teams][1][:team]).to eq(
        {"avatar"=>"https://s3-ap-southeast-1.amazonaws.com/pantau-test/assets/teams/avatar_team_2.png", "id"=>2, "title"=>"Prabowo - Sandi"}
      )
    end

    it "User preference" do
      get "/pendidikan_politik/v1/quiz_participations/quizzes",
        params: {
          user_id: "1036fd3c-04ed-4949-b57c-b7dc8ff3e737"
        }
      
      expect(json_response[:data][:user][:id]).to eq("1036fd3c-04ed-4949-b57c-b7dc8ff3e737")
      expect(json_response[:data][:teams].size).to eq(2)
      expect(json_response[:data][:teams][0][:percentage]).not_to eq(nil)
      expect(json_response[:data][:teams][1][:percentage]).not_to eq(nil)
    end

  end

end
