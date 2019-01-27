require 'rails_helper'

describe API::V1::Lapor::ViolationReports::Resources::Me do
  describe 'GET /v1/me/reports' do
    context 'when authorized' do
      let!(:earlier_report) { create :violation_report, reporter_id: current_user.id, created_at: '2000-01-01' }
      let!(:recent_report) { create :violation_report, reporter_id: current_user.id, created_at: '2000-01-02' }
      let!(:other_user_report) { create :violation_report }

      before { get '/lapor/v1/me/reports', headers: stub_auth_headers(user: current_user) }

      it { expect(response).to have_http_status(:ok) }

      it "presents the authorized user's violation reports in descending order by creation time" do
        expect(json_response).to match(
          data: a_hash_including(
            reports: [recent_report, earlier_report].map! { |report|
              { id: report.id,
                reporter: {
                  id: current_user.id,
                  email: current_user.email,
                  full_name: current_user.full_name,
                  avatar: current_user.avatar,
                  verified: current_user.verified
                },
                dimension_id: report.dimension_id,
                title: report.title,
                description: report.description,
                created_at: report.created_at.as_json,
                updated_at: report.updated_at.as_json
              }
            }
          )
        )
      end

      include_examples 'presents pagination meta'

      let(:current_user) { create :user }
    end

    context 'when unauthorized' do
      before { get '/lapor/v1/me/reports' }

      it { expect(response).to have_http_status(:unauthorized) }
    end
  end
end