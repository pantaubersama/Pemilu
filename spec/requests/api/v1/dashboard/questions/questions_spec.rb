require 'rails_helper'

RSpec.describe "Api::V1::Dashboard::Quizzes", type: :request do
  before do
    @access_token = SecureRandom.hex
    stub_user_model
  end
  let(:quiz) { FactoryBot.create :quiz }
  
  describe "Authorized" do
    it "authorized" do
      question = FactoryBot.create :quiz_question, quiz: quiz
      get "/dashboard/v1/questions/#{question.id}", headers: stub_admin_auth_headers(@access_token),
        params: {
          quiz_id: quiz.id
        }
      expect(response.status).to eq(200)
    end
    it "not authorized" do
      question = FactoryBot.create :quiz_question, quiz: quiz
      get "/dashboard/v1/questions/#{question.id}", headers: stub_not_authorized_headers(@access_token),
      params: {
        quiz_id: quiz.id
      }
      expect(response.status).to eq(403)
    end
  end

  describe "Trash" do
    it "success" do
      5.times do
        FactoryBot.create :question
      end
      Question.last.destroy!
      get "/dashboard/v1/questions/trash", headers: stub_admin_auth_headers(@access_token)
      expect(response.status).to eq(200)
      expect(json_response[:data][:questions].size).to eq(1)
    end
  end

  describe "Add" do
    it "success" do
      post "/dashboard/v1/questions", headers: stub_admin_auth_headers(@access_token),
        params: {
          quiz_id: quiz.id,
          content: "Ini pertanyaan ?",
          team_1_answer: "Jawaban team 1",
          team_2_answer: "Jawaban team 2"
        }
      expect(response.status).to eq(201)
      expect(json_response[:data][:questions].size).to eq(1)
    end
  end

  describe "Edit" do
    it "success" do
      q = FactoryBot.create :quiz_question, quiz: quiz
      a1 = FactoryBot.create :quiz_answer, quiz_question: q, team: 1
      a2 = FactoryBot.create :quiz_answer, quiz_question: q, team: 2
      put "/dashboard/v1/questions/#{q.id}", headers: stub_admin_auth_headers(@access_token),
        params: {
          quiz_id: quiz.id,
          content: "Ini pertanyaan ?",
          team_1_answer: "Jawaban team 1",
          team_2_answer: "Jawaban team 2"
        }
      
      expect(response.status).to eq(200)
      expect(json_response[:data][:questions].size).to eq(1)
    end
  end

  describe "delete" do
    it "success" do
      q = FactoryBot.create :quiz_question, quiz: quiz
      a1 = FactoryBot.create :quiz_answer, quiz_question: q, team: 1
      a2 = FactoryBot.create :quiz_answer, quiz_question: q, team: 2

      delete "/dashboard/v1/questions/#{q.id}", headers: stub_admin_auth_headers(@access_token), 
        params: {
          quiz_id: quiz.id
        }
      expect(response.status).to eq(200)
    end
  end

  describe "show" do
    it "success" do
      question = FactoryBot.create :quiz_question, quiz: quiz
      get "/dashboard/v1/questions/#{question.id}", headers: stub_admin_auth_headers(@access_token),
        params: {
          quiz_id: quiz.id
        }
      expect(response.status).to eq(200)
    end
  end

end
