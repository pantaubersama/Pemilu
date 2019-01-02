require 'rails_helper'

RSpec.describe "Api::V1::PendidikanPolitik::Resources::Quizzes", type: :request do
  before do
    @access_token = SecureRandom.hex(32)
    5.times do
      FactoryBot.create :question
    end
    stub_find_user_2
  end

  describe "List quiz" do
    before do
      post "/pendidikan_politik/v1/only_staging/generate_random_quiz", params: {total_question: 1}
      post "/pendidikan_politik/v1/only_staging/generate_random_quiz", params: {total_question: 3}
      post "/pendidikan_politik/v1/only_staging/generate_random_quiz", params: {total_question: 3}

      @quiz = Quiz.first
    end

    it "should success" do
      get "/pendidikan_politik/v1/quizzes", headers: stub_auth_headers(@access_token)
      expect(response.status).to eq(200)
    end

    it "no filter success" do
      get "/pendidikan_politik/v1/quizzes", headers: stub_auth_headers(@access_token)
    end

    it "filter 'all' success" do
      get "/pendidikan_politik/v1/quizzes", headers: stub_auth_headers(@access_token), params: {filter_by: "all"}
      expect(json_response[:data][:quizzes].size).to eq(3)
      expect(json_response[:data][:quizzes].map{|x| x[:participation_status]}.uniq.size).to eq(1)
      expect(json_response[:data][:quizzes].map{|x| x[:participation_status]}.uniq).to eq(["not_participating"])
    end

    it "filter 'not_participating' success" do
      get "/pendidikan_politik/v1/quizzes", headers: stub_auth_headers(@access_token), params: {filter_by: "not_participating"}
      expect(json_response[:data][:quizzes].size).to eq(3)
      expect(json_response[:data][:quizzes].map{|x| x[:participation_status]}.uniq.size).to eq(1)
      expect(json_response[:data][:quizzes].map{|x| x[:participation_status]}.uniq).to eq(["not_participating"])
    end

    it "filter 'in_progress' success" do
      get "/pendidikan_politik/v1/quizzes/#{@quiz.id}/questions", headers: stub_auth_headers(@access_token)
      get "/pendidikan_politik/v1/quizzes", headers: stub_auth_headers(@access_token), params: {filter_by: "in_progress"}
      expect(json_response[:data][:quizzes].size).to eq(1)
      expect(json_response[:data][:quizzes].map{|x| x[:participation_status]}.uniq.size).to eq(1)
      expect(json_response[:data][:quizzes].map{|x| x[:participation_status]}.uniq).to eq(["in_progress"])
    end

    it "filter 'finished' success" do
      get "/pendidikan_politik/v1/quizzes/#{@quiz.id}/questions", headers: stub_auth_headers(@access_token)
      question = json_response[:data][:questions].last[:id]
      answer = json_response[:data][:questions].last[:answers].last[:id]

      post "/pendidikan_politik/v1/quizzes/#{@quiz.id}/questions", headers: stub_auth_headers(@access_token), params: {question_id: question, answer_id: answer}
      get "/pendidikan_politik/v1/quizzes", headers: stub_auth_headers(@access_token), params: {filter_by: "finished"}

      expect(json_response[:data][:quizzes].size).to eq(1)
      expect(json_response[:data][:quizzes].map{|x| x[:participation_status]}.uniq.size).to eq(1)
      expect(json_response[:data][:quizzes].map{|x| x[:participation_status]}.uniq).to eq(["finished"])
    end
  end

  describe "Participate in quiz" do
    before do
      post "/pendidikan_politik/v1/only_staging/generate_random_quiz", params: {total_question: 1}

      @quiz = Quiz.first
    end

    it "display detail quiz" do
      get "/pendidikan_politik/v1/quizzes/#{@quiz.id}", headers: stub_auth_headers(@access_token)
      expect(response.status).to eq(200)
      expect(json_response[:data][:quiz][:participation_status]).to eq("not_participating")
    end

    it "participate in quiz" do
      get "/pendidikan_politik/v1/quizzes/#{@quiz.id}/questions", headers: stub_auth_headers(@access_token)
      expect(json_response[:data][:quiz_participation][:status]).to eq("in_progress")
      expect(json_response[:data][:meta][:quizzes][:answered_questions_count]).to eq(0)
    end

    it "continue quiz" do
      get "/pendidikan_politik/v1/quizzes/#{@quiz.id}/questions", headers: stub_auth_headers(@access_token)
      expect(json_response[:data][:quiz_participation][:status]).to eq("in_progress")
      expect(json_response[:data][:meta][:quizzes][:answered_questions_count]).to eq(0)

      get "/pendidikan_politik/v1/quizzes/#{@quiz.id}/questions", headers: stub_auth_headers(@access_token)
      expect(json_response[:data][:quiz_participation][:status]).to eq("in_progress")
      expect(json_response[:data][:meta][:quizzes][:answered_questions_count]).to eq(0)
    end

    it "answering quiz" do
      get "/pendidikan_politik/v1/quizzes/#{@quiz.id}/questions", headers: stub_auth_headers(@access_token)
      expect(json_response[:data][:quiz_participation][:status]).to eq("in_progress")
      expect(json_response[:data][:meta][:quizzes][:answered_questions_count]).to eq(0)
      question = json_response[:data][:questions].last[:id]
      answer = json_response[:data][:questions].last[:answers].last[:id]

      post "/pendidikan_politik/v1/quizzes/#{@quiz.id}/questions", headers: stub_auth_headers(@access_token), params: {question_id: question, answer_id: answer}
      expect(json_response[:data][:meta][:quizzes][:answered_questions_count]).to eq(1)
      expect(json_response[:data][:quiz_participation][:status]).to eq("finished")
    end

  end

  describe "Participate in different quizzes" do
    before do
      post "/pendidikan_politik/v1/only_staging/generate_random_quiz", params: {total_question: 3}

      @quiz = Quiz.first
    end

    it "answering quiz (in progress)" do
      get "/pendidikan_politik/v1/quizzes/#{@quiz.id}", headers: stub_auth_headers(@access_token)
      expect(response.status).to eq(200)
      expect(json_response[:data][:quiz][:participation_status]).to eq("not_participating")

      get "/pendidikan_politik/v1/quizzes/#{@quiz.id}/questions", headers: stub_auth_headers(@access_token)
      expect(json_response[:data][:quiz_participation][:status]).to eq("in_progress")
      expect(json_response[:data][:meta][:quizzes][:answered_questions_count]).to eq(0)
      question = json_response[:data][:questions].last[:id]
      answer = json_response[:data][:questions].last[:answers].last[:id]

      post "/pendidikan_politik/v1/quizzes/#{@quiz.id}/questions", headers: stub_auth_headers(@access_token), params: {question_id: question, answer_id: answer}
      expect(json_response[:data][:meta][:quizzes][:answered_questions_count]).to eq(1)
      expect(json_response[:data][:quiz_participation][:status]).to eq("in_progress")

      get "/pendidikan_politik/v1/quizzes/#{@quiz.id}", headers: stub_auth_headers(@access_token)
      expect(response.status).to eq(200)
      expect(json_response[:data][:quiz][:participation_status]).to eq("in_progress")
    end

  end

  describe "Quiz result and summary" do
    before do
      post "/pendidikan_politik/v1/only_staging/generate_random_quiz", params: {total_question: 3}

      @quiz = Quiz.first

      get "/pendidikan_politik/v1/quizzes/#{@quiz.id}", headers: stub_auth_headers(@access_token)
      get "/pendidikan_politik/v1/quizzes/#{@quiz.id}/questions", headers: stub_auth_headers(@access_token)
      
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

    it "Quiz is finished" do
      get "/pendidikan_politik/v1/quizzes/#{@quiz.id}", headers: stub_auth_headers(@access_token)
      expect(json_response[:data][:quiz][:participation_status]).to eq("finished")
    end

    it "Quiz result" do
      get "/pendidikan_politik/v1/quizzes/#{@quiz.id}/result", headers: stub_auth_headers(@access_token)
      expect(json_response[:data][:answers].size).to eq(3)
      expect(json_response[:data][:teams].size).to eq(2)
      expect(json_response[:data][:teams][0][:percentage]).to be >= 0.0
      expect(json_response[:data][:teams][1][:percentage]).to be >= 0.0

      expect(json_response[:data][:teams][0][:team]).to eq(
        {"avatar"=>"https://s3-ap-southeast-1.amazonaws.com/pantau-test/assets/teams/avatar_team_1.png", "id"=>1, "title"=>"Jokowi - Makruf"}
      )
      expect(json_response[:data][:teams][1][:team]).to eq(
        {"avatar"=>"https://s3-ap-southeast-1.amazonaws.com/pantau-test/assets/teams/avatar_team_2.png", "id"=>2, "title"=>"Prabowo - Sandi"}
      )
    end

    it "Quiz summary" do
      get "/pendidikan_politik/v1/quizzes/#{@quiz.id}/summary", headers: stub_auth_headers(@access_token)
      expect(json_response[:data][:questions].size).to eq(3)
      expect(json_response[:data][:questions][0][:answered][:id]).not_to eq(nil)
      expect(json_response[:data][:questions][1][:answered][:id]).not_to eq(nil)
      expect(json_response[:data][:questions][2][:answered][:id]).not_to eq(nil)
    end

    it "My preference" do
      get "/pendidikan_politik/v1/me/quizzes", headers: stub_auth_headers(@access_token)
      expect(json_response[:data][:teams].size).to eq(2)
      expect(json_response[:data][:teams][0][:percentage]).not_to eq(nil)
      expect(json_response[:data][:teams][1][:percentage]).not_to eq(nil)
    end

  end
  

end