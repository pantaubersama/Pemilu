require 'rails_helper'

RSpec.describe "Api::V1::Dashboard::QuestionsActions", type: :request do
  before do
    @access_token = SecureRandom.hex
		stub_user_model
  end
  
  describe "Edit Question" do
		it "success" do
      question = FactoryBot.create :question
      folder = FactoryBot.create(:question_folder)
      put "/dashboard/v1/question_actions/#{question.id}", headers: stub_admin_auth_headers(@access_token),
        params: {
					id: question.id,
          body: "Edited Question",
          status: "archived",
          question_folder_id: folder.id
        }
			expect(response.status).to eq(200)
      expect(json_response[:data][:questions][:body]).to eq("Edited Question")
      expect(json_response[:data][:questions][:status]).to eq("archived")
      expect(json_response[:data][:questions][:question_folder_id]).to eq(folder.id)
      expect(json_response[:data][:questions][:question_folder][:name]).to eq(folder.name)
    end
  end

  describe "Delete Question" do
		it "success" do
      question = FactoryBot.create :question
      delete "/dashboard/v1/question_actions", headers: stub_admin_auth_headers(@access_token),
        params: {
					id: question.id
        }
			expect(response.status).to eq(200)
    end
  end

  describe "Trash" do
    it "success" do
      3.times do
        FactoryBot.create :question
      end
      Question.first.destroy!
      Question.last.destroy!
      get "/dashboard/v1/question_actions/trash", headers: stub_admin_auth_headers(@access_token)
      expect(response.status).to eq(200)
      expect(json_response[:data][:questions].size).to eq(2)
    end
  end

  describe "Detail Trash" do
    it "success" do
      FactoryBot.create :question
      Question.last.destroy!
      question = Question.deleted.last
      get "/dashboard/v1/question_actions/trash/#{question.id}", headers: stub_admin_auth_headers(@access_token)
      expect(response.status).to eq(200)
      expect(json_response[:data][:questions][:id]).to eq(question.id)
    end
  end
end
