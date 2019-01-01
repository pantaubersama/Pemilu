require 'rails_helper'

RSpec.describe QuizQuestion, type: :model do
  describe "Should success" do
    it "with valid params" do
      a = FactoryBot.create :quiz_question
      expect(a.quiz_id).not_to eq(nil) 
      expect(a.quiz.quiz_questions_count).to eq(1) 
    end
  end
end
