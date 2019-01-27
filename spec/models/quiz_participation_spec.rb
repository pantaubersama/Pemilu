require 'rails_helper'

RSpec.describe QuizParticipation, type: :model do
  before do
    stub_user_model
    @user = User.find "c9242c5a-805b-4ef5-b3a7-2a7f25785cc8"
    @quiz = FactoryBot.create :quiz
  end
  describe "Should success" do
    it "In progress" do
      a = FactoryBot.create :quiz_participation, status: 0, user_id: @user.id, quiz: @quiz
      expect(a.status).to eq("in_progress") 
    end

    it "Finished" do
      a = FactoryBot.create :quiz_participation, status: 1, user_id: @user.id, quiz: @quiz
      expect(a.status).to eq("finished") 
    end

    it "In progress then Finished" do
      a = FactoryBot.create :quiz_participation, status: 0, user_id: @user.id, quiz: @quiz
      expect(a.status).to eq("in_progress") 

      a.finished!
      expect(a.status).to eq("finished") 
    end
  end
end
