require 'rails_helper'

describe API::V1::Reports::Resources::Reports do
  describe 'POST /v1/reports' do
    it 'reports question' do
      expect { report question }.to change { question.reload.cached_scoped_report_votes_down }.by(1)
      expect(response).to have_http_status(:created)
      expect(json_response).to match(data: a_hash_including(vote: a_hash_including(status: true, text: 'Success')))
    end

    it 'cannot report reported question by the same person' do
      report question
      expect { report question }.not_to change { question.reload.cached_scoped_report_votes_down }
      expect(response).to have_http_status(:created)
      expect(json_response).to match(data: a_hash_including(vote: a_hash_including(status: false)))
    end

    it 'cannot report foldered question' do
      question.update! question_folder: create(:question_folder)
      expect { report question }.not_to change { question.reload.cached_scoped_report_votes_down }
      expect(response).to have_http_status(:not_found)
    end

    it 'reports violation report' do
      expect { report violation_report }.to change { violation_report.reload.cached_scoped_report_votes_down }.by(1)
      expect(response).to have_http_status(:created)
      expect(json_response).to match(data: a_hash_including(vote: a_hash_including(status: true)))
    end

    it 'cannot report reported violation report by the same person' do
      violation_report.reported_by user
      expect { report violation_report }.not_to change { violation_report.reload.cached_scoped_report_votes_down }
      expect(response).to have_http_status(:created)
      expect(json_response).to match(data: a_hash_including(vote: a_hash_including(status: false)))
    end

    it 'rejects unlisted class_name' do
      report double(id: SecureRandom.hex)
      expect(response).to have_http_status(:not_acceptable)
    end

    let(:user) { create :user }
    let(:question) { create :question }
    let(:violation_report) { create :violation_report }

    def report(reportable)
      params = { id: reportable.id, class_name: reportable.class.name }
      post '/pendidikan_politik/v1/reports', headers: stub_auth_headers(user: user), params: params
    end
  end
end