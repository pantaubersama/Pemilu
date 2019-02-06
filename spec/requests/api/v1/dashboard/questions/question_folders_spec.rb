require 'rails_helper'

RSpec.describe "Api::V1::Dashboard::QuestionsFolder", type: :request do
  before do
    @access_token = SecureRandom.hex
    @folder = FactoryBot.create :question_folder
    @question = FactoryBot.create :question, question_folder_id: @folder.id, status: "archived"
    the_q = FactoryBot.create :question
    stub_user_model
  end
  
  describe "Authorized" do
    it "authorized" do
      get "/dashboard/v1/question_folders/#{@folder.id}/questions", headers: stub_admin_auth_headers(@access_token)
      expect(response.status).to  eq(200)
    end
    it "not authorized" do
      get "/dashboard/v1/question_folders/#{@folder.id}/questions", headers: stub_not_authorized_headers(@access_token)
      expect(response.status).to  eq(403)
    end
  end

  describe "list question folder" do
    it "success" do
      get "/dashboard/v1/question_folders/#{@folder.id}/questions", headers: stub_admin_auth_headers(@access_token)
      expect(json_response[:data][:question_folder][:name]).to  eq(@folder.name)
      expect(json_response[:data][:question_folder][:questions_count]).to  eq(1)
      expect(json_response[:data][:questions].size).to  eq(1)
    end
  end

  describe "add / update questions in question folder" do
    it "success" do
      @folder2 = FactoryBot.create :question_folder
      @question1 = FactoryBot.create :question, question_folder_id: @folder2.id
      @question2 = FactoryBot.create :question, question_folder_id: @folder2.id      

      put "/dashboard/v1/question_folders/#{@folder2.id}/questions", headers: stub_admin_auth_headers(@access_token),
        params: {
          question_ids: [@question1.id, @question2.id].join(", ")
        }
      expect(json_response[:data][:question_folder][:name]).to  eq(@folder2.name)
      expect(json_response[:data][:question_folder][:questions_count]).to  eq(2)
      expect(json_response[:data][:questions].size).to  eq(2)

      Question.reindex
      get "/pendidikan_politik/v1/questions"
      expect(json_response[:data][:questions].size).to eq(1)
    end
  end

end
