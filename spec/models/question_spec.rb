require 'rails_helper'

RSpec.describe Question, type: :model do
  describe "Should validate" do
    it "min length" do
      a = Question.new body: "a"
      expect(a).to_not be_valid 
    end

    it "max length" do
      a = Question.new body: "Non cupidatat cupidatat ex sint occaecat in nulla. Enim exercitation sint cupidatat dolore. Pariatur duis in culpa ut enim laboris consequat adipisicing consectetur pariatur nisi est minim sint. Non cupidatat cupidatat ex sint occaecat in nulla. Enim exercitation sint cupidatat dolore. Pariatur duis in culpa ut enim laboris consequat adipisicing consectetur pariatur nisi est minim sint."
      expect(a).to_not be_valid 
    end

    it "should have user" do
      a = Question.new body: "Non cupidatat cupidatat ex sint occaecat in nulla."
      expect(a).to_not be_valid 
    end
  end

  describe "Should success" do
    it "with valid params" do
      a = Question.new body: "Non cupidatat cupidatat ex sint occaecat in nulla.", user_id: "c9242c5a-805b-4ef5-b3a7-2a7f25785cc8"
      expect(a).to be_valid 
    end
  end

  describe "Could Vote" do
    before do
      stub_find_user
      @question = FactoryBot.create :question
      @current_user = User.find "c9242c5a-805b-4ef5-b3a7-2a7f25785cc8"
    end
    it "once" do
      @question.liked_by @current_user
      expect(@question.vote_registered?).to eq true

      @question.liked_by @current_user
      expect(@question.vote_registered?).to eq false
    end
  end
end
