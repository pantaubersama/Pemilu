require 'rails_helper'

RSpec.describe Quiz, type: :model do
  describe "Should success" do
    it "with valid params" do
      a = FactoryBot.create :quiz
      expect(a.id).not_to eq(nil) 
    end
  end

  describe "Create full quiz" do
    it "success with question and answer" do
      quiz = FactoryBot.create :quiz

      question_1 = FactoryBot.create :quiz_question, quiz: quiz
      question_2 = FactoryBot.create :quiz_question, quiz: quiz
      question_3 = FactoryBot.create :quiz_question, quiz: quiz

      FactoryBot.create :quiz_answer, team: 1, quiz_question_id: question_1.id
      FactoryBot.create :quiz_answer, team: 2, quiz_question_id: question_1.id

      FactoryBot.create :quiz_answer, team: 1, quiz_question_id: question_2.id
      FactoryBot.create :quiz_answer, team: 2, quiz_question_id: question_2.id

      FactoryBot.create :quiz_answer, team: 1, quiz_question_id: question_3.id
      FactoryBot.create :quiz_answer, team: 2, quiz_question_id: question_3.id

      expect(quiz.quiz_questions_count).to eq(3)

      expect(quiz.quiz_questions.map{|q| q.quiz_answers.count }.reduce(:+)).to eq(6)
      
      expect(question_1.quiz_answers.count).to eq(2)
      expect(question_2.quiz_answers.count).to eq(2)
      expect(question_3.quiz_answers.count).to eq(2)
      
    end
  end
end
