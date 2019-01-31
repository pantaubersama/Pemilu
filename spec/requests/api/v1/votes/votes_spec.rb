require 'rails_helper'

describe API::V1::Votes::Resources::Votes do
  describe 'POST /v1/votes' do
    it 'likes question' do
      expect { like question }.to change { question.reload.cached_votes_up }.by(1)
      expect(response).to have_http_status(:created)
      expect(json_response).to match(data: a_hash_including(vote: a_hash_including(status: true)))
    end

    it 'cannot like liked question by the same person' do
      question.liked_by user
      expect { like question }.not_to change { question.reload.cached_votes_up }
      expect(response).to have_http_status(:created)
      expect(json_response).to match(data: a_hash_including(vote: a_hash_including(status: false)))
    end

    it 'rejects unlisted class_name' do
      params = { id: SecureRandom.uuid, class_name: 'UnlistedModel' }
      post '/pendidikan_politik/v1/votes', headers: stub_auth_headers(user: user), params: params
      expect(response).to have_http_status(:not_acceptable)
    end

    it 'cannot like foldered question' do
      like foldered_question
      expect(response).to have_http_status(:not_found)
    end

    def like(question)
      params = { id: question.id, class_name: 'Question' }
      post '/pendidikan_politik/v1/votes', headers: stub_auth_headers(user: user), params: params
    end
  end

  describe 'DELETE /v1/votes' do
    it 'unlikes question' do
      question.liked_by user
      expect { unlike question }.to change { question.reload.cached_votes_up }.by(-1)
      expect(response).to have_http_status(:ok)
      expect(json_response).to match(data: a_hash_including(vote: a_hash_including(status: true)))
    end

    it 'cannot unlike unliked question' do
      expect { unlike question }.not_to change { question.reload.cached_votes_up }
      expect(response).to have_http_status(:not_found)
    end

    it 'cannot unlike foldered question' do
      unlike foldered_question
      expect(response).to have_http_status(:not_found)
    end

    def unlike(question)
      params = { id: question.id, class_name: 'Question' }
      delete '/pendidikan_politik/v1/votes', headers: stub_auth_headers(user: user), params: params
    end
  end

  let(:user) { create :user }
  let(:question) { create :question, user_id: user.id }
  let(:foldered_question) { create :foldered_question, user_id: user.id }
end
