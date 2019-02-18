require 'rails_helper'

describe API::V1::Dashboard::Votes::Resources::Votes do
  describe 'POST /dashboard/v1/votes' do
    it 'likes question' do
      expect { like question }.to change { question.reload.cached_votes_up }.by(10)
      expect(response).to have_http_status(:created)
      expect(json_response).to match(data: a_hash_including(vote: a_hash_including(status: true)))
    end

    it 'can like liked question by the same person' do
      question.liked_by user
      expect { like question }.to change { question.reload.cached_votes_up }
      expect(response).to have_http_status(:created)
      expect(json_response).to match(data: a_hash_including(vote: a_hash_including(status: true)))
    end

    it 'cannot like foldered question' do
      like foldered_question
      expect(response).to have_http_status(:not_found)
    end

    def like(question)
      params = { id: question.id, class_name: 'Question', vote_count: 10 }
      user.update(username: :surveymanual, is_admin: true)
      post '/dashboard/v1/votes', headers: stub_auth_headers(user: user), params: params
    end
  end


  let(:user) { create :user }
  let(:question) { create :question, user_id: user.id }
  let(:foldered_question) { create :foldered_question, user_id: user.id }
end
