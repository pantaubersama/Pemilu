require 'rails_helper'

RSpec.describe "Api::V1::Users::Resources::Questions", type: :request do
  before do
    @access_token = SecureRandom.hex
    5.times do
      FactoryBot.create :question, user_id: "c9242c5a-805b-4ef5-b3a7-2a7f25785cc8"
    end
    stub_user_model
  end

  describe "User question" do
    it "Have 7 question, question in folder is displayed" do
      FactoryBot.create :question, user_id: "c9242c5a-805b-4ef5-b3a7-2a7f25785cc8"
      FactoryBot.create :question, question_folder_id: FactoryBot.create(:question_folder).id, user_id: "c9242c5a-805b-4ef5-b3a7-2a7f25785cc8", status: "archived"
      Question.reindex
      get "/pendidikan_politik/v1/users/c9242c5a-805b-4ef5-b3a7-2a7f25785cc8/questions"
      expect(json_response[:data][:questions].size).to eq(7) # question in folder is displayed
    end

    it "Have 2 question, optional current_user, question in folder is displayed" do
      FactoryBot.create :question, user_id: "1036fd3c-04ed-4949-b57c-b7dc8ff3e737"
      FactoryBot.create :question, question_folder_id: FactoryBot.create(:question_folder).id, user_id: "1036fd3c-04ed-4949-b57c-b7dc8ff3e737", status: "archived"
      Question.reindex
      get "/pendidikan_politik/v1/users/1036fd3c-04ed-4949-b57c-b7dc8ff3e737/questions", headers: stub_auth_headers(@access_token)
      expect(json_response[:data][:questions].size).to eq(2) # question in folder is displayed
    end
  end

end
