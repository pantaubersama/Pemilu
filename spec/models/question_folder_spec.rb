require 'rails_helper'

RSpec.describe QuestionFolder, type: :model do
  describe "Should success" do
    it "with valid params" do
      a = FactoryBot.create :question_folder
      expect(a).to be_valid 
    end
  end

  describe "Should success" do
    before do
      @folder = FactoryBot.create :question_folder
    end
    it "Success without folder" do
      a = Question.new body: Faker::Lorem.words(2), user_id: "c9242c5a-805b-4ef5-b3a7-2a7f25785cc8"
      expect(a).to be_valid 
    end
    it "Success with folder" do
      a = Question.new question_folder_id: @folder.id, body: Faker::Lorem.words(2), user_id: "c9242c5a-805b-4ef5-b3a7-2a7f25785cc8"
      expect(a).to be_valid 
    end
  end
end
