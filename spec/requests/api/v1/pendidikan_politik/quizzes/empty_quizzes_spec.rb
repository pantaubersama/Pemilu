require 'rails_helper'

RSpec.describe "Api::V1::PendidikanPolitik::Resources::Quizzes", type: :request do
  before do
    @access_token = SecureRandom.hex
  end

  describe "empty record" do
    it "has no error" do
      Quiz.reindex
      get "/pendidikan_politik/v1/quizzes", headers: stub_auth_headers(@access_token),
        params: {page: 1, per_page: 5}
      expect(response.status).to eq(200)
      expect(json_response[:data][:quizzes].size).to eq(0)
    end
  end
end