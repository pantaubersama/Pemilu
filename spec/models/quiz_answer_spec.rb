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

      expect(@quiz_question.quiz_answers.first.team_source).to eq({
                                                                      :avatar => "https://s3-ap-southeast-1.amazonaws.com/pantau-test/assets/teams/avatar_team_1.png",
                                                                      :id     => 1,
                                                                      :title  => "Jokowi - Ma'ruf"
                                                                  })
      expect(@quiz_question.quiz_answers.last.team_source).to eq({
                                                                     :avatar => "https://s3-ap-southeast-1.amazonaws.com/pantau-test/assets/teams/avatar_team_2.png",
                                                                     :id     => 2,
                                                                     :title  => "Prabowo - Sandi"
                                                                 })
    end
  end
end
