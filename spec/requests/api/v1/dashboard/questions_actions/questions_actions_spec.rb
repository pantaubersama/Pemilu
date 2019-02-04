require 'rails_helper'

RSpec.describe "Api::V1::Dashboard::QuestionsActions", type: :request do
  before do
    @access_token = SecureRandom.hex
		stub_user_model
  end
  
  describe "Edit Question" do
		it "success" do
      question = FactoryBot.create :question
      put "/dashboard/v1/question_actions/#{question.id}", headers: stub_admin_auth_headers(@access_token),
        params: {
					id: question.id,
					body: "Edited Question"
        }
			expect(response.status).to eq(200)
      expect(json_response[:data][:questions][:body]).to eq("Edited Question")
    end
  end

end
