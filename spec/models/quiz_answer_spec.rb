require 'rails_helper'

RSpec.describe QuizAnswer, type: :model do
  describe "Should success" do
    before do
      @quiz_question = FactoryBot.create :quiz_question
    end
    it "with valid params" do
      answer_1 = FactoryBot.create :quiz_answer, team: 1, quiz_question_id: @quiz_question.id
      answer_2 = FactoryBot.create :quiz_answer, team: 2, quiz_question_id: @quiz_question.id
      
      expect(@quiz_question.quiz_answers.count).to eq(2) 
      expect(@quiz_question.quiz_answers.first.team).to eq(1) 
      expect(@quiz_question.quiz_answers.last.team).to eq(2)
      
      expect(@quiz_question.quiz_answers.first.team_text).to eq("Jokowi - Makruf") 
      expect(@quiz_question.quiz_answers.last.team_text).to eq("Prabowo - Sandi")
    end
  end
end
