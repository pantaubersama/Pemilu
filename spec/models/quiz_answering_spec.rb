require 'rails_helper'

RSpec.describe QuizAnswering, type: :model do
  # class QuizAnswering < ApplicationRecord
  #   include Userable
  
  #   belongs_to :quiz_participation
  #   belongs_to :quiz
  #   belongs_to :quiz_question
  #   belongs_to :quiz_answer
    
  # end

  before do
    stub_find_user
    @user = User.find "c9242c5a-805b-4ef5-b3a7-2a7f25785cc8"

    @quiz = FactoryBot.create :quiz

    @question_1 = FactoryBot.create :quiz_question, quiz: @quiz
    @question_2 = FactoryBot.create :quiz_question, quiz: @quiz
    @question_3 = FactoryBot.create :quiz_question, quiz: @quiz

    @answer_1 = FactoryBot.create :quiz_answer, team: 1, quiz_question_id: @question_1.id
    @answer_2 = FactoryBot.create :quiz_answer, team: 2, quiz_question_id: @question_1.id

    @answer_3 = FactoryBot.create :quiz_answer, team: 1, quiz_question_id: @question_2.id
    @answer_4 = FactoryBot.create :quiz_answer, team: 2, quiz_question_id: @question_2.id

    @answer_5 = FactoryBot.create :quiz_answer, team: 1, quiz_question_id: @question_3.id
    @answer_6 = FactoryBot.create :quiz_answer, team: 2, quiz_question_id: @question_3.id
  end

  describe "Should success" do
    it "Should only one time answer" do
      participation = FactoryBot.create :quiz_participation, quiz: @quiz, user_id: @user.id, status: 0

      a = FactoryBot.create :quiz_answering, user_id: @user.id, quiz_participation: participation, 
        quiz: participation.quiz, quiz_question: @question_1, quiz_answer: @answer_2

      expect(participation.status).to eq("in_progress")
      
      # double answer
      expect{
        a = FactoryBot.create :quiz_answering, user_id: @user.id, quiz_participation: participation, 
          quiz: participation.quiz, quiz_question: @question_1, quiz_answer: @answer_1
      }.to raise_error(ActiveRecord::RecordInvalid)

      # another answer
      a = FactoryBot.create :quiz_answering, user_id: @user.id, quiz_participation: participation, 
        quiz: participation.quiz, quiz_question: @question_2, quiz_answer: @answer_1
      expect(a).to be_valid
    end

    it "Create answering quiz" do
      participation = FactoryBot.create :quiz_participation, quiz: @quiz, user_id: @user.id, status: 0

      expect(participation.status).to eq("in_progress")  

      a = FactoryBot.create :quiz_answering, user_id: @user.id, quiz_participation: participation, 
        quiz: participation.quiz, quiz_question: @question_1, quiz_answer: @answer_2

      expect(participation.status).to eq("in_progress")
      

      a = FactoryBot.create :quiz_answering, user_id: @user.id, quiz_participation: participation, 
        quiz: participation.quiz, quiz_question: @question_2, quiz_answer: @answer_1

      expect(participation.status).to eq("in_progress")

      a = FactoryBot.create :quiz_answering, user_id: @user.id, quiz_participation: participation, 
        quiz: participation.quiz, quiz_question: @question_3, quiz_answer: @answer_1
      participation.finished!

      expect(participation.status).to eq("finished")
      expect(participation.quiz_answerings.count).to eq(3)
      expect(participation.quiz_answerings.map{|qa| qa.quiz_answer.team }).to eq([ 2, 1, 1 ])
    end
  end
  
end
