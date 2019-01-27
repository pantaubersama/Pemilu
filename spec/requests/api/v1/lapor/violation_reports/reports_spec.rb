require 'rails_helper'

describe API::V1::Lapor::ViolationReports::Resources::Reports do
  describe 'GET /v1/reports', :search do
    context 'by default' do
      let!(:earlier_report) { create :violation_report, reporter_id: user.id, created_at: '2000-01-01' }
      let!(:recent_report) { create :violation_report, reporter_id: user.id, created_at: '2000-01-02' }

      before do
        ViolationReport::Report.reindex
        get '/lapor/v1/reports'
      end

      it { expect(response).to have_http_status(:ok) }

      it 'presents violation reports in descending order by creation time' do
        expect(json_response).to match(
          data: a_hash_including(
            reports: [recent_report, earlier_report].map { |report|
              { id: report.id,
                reporter: {
                  id: user.id,
                  email: user.email,
                  full_name: user.full_name,
                  avatar: user.avatar,
                  verified: user.verified
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

      let(:user) { create :user }
    end

    context 'when verification parameter is set to verified' do
      let!(:verified_user_report) { create :violation_report, reporter_id: verified_user.id }
      let!(:unverified_user_report) { create :violation_report, reporter_id: unverified_user.id }

      before do
        ViolationReport::Report.reindex
        get '/lapor/v1/reports', params: { verification: 'verified' }
      end

      it { expect(response).to have_http_status(:ok) }

      it 'presents violation reports created by verified users only' do
        expect(json_response).to match(
          data: a_hash_including(
            reports: [
              { id: verified_user_report.id,
                reporter: {
                  id: verified_user.id,
                  email: verified_user.email,
                  full_name: verified_user.full_name,
                  avatar: verified_user.avatar,
                  verified: verified_user.verified
                },
                dimension_id: verified_user_report.dimension_id,
                title: verified_user_report.title,
                description: verified_user_report.description,
                created_at: verified_user_report.created_at.as_json,
                updated_at: verified_user_report.updated_at.as_json
              }
            ]
          )
        )
      end

      include_examples 'presents pagination meta'

      let(:verified_user) { create :verified_user }
      let(:unverified_user) { create :user }
    end

    context 'when verification parameter is set to unverified' do
      let!(:verified_user_report) { create :violation_report, reporter_id: verified_user.id }
      let!(:unverified_user_report) { create :violation_report, reporter_id: unverified_user.id }

      before do
        ViolationReport::Report.reindex
        get '/lapor/v1/reports', params: { verification: 'unverified' }
      end

      it { expect(response).to have_http_status(:ok) }

      it 'presents violation reports created by unverified users only' do
        expect(json_response).to match(
          data: a_hash_including(
            reports: [
              { id: unverified_user_report.id,
                reporter: {
                  id: unverified_user.id,
                  email: unverified_user.email,
                  full_name: unverified_user.full_name,
                  avatar: unverified_user.avatar,
                  verified: unverified_user.verified
                },
                dimension_id: unverified_user_report.dimension_id,
                title: unverified_user_report.title,
                description: unverified_user_report.description,
                created_at: unverified_user_report.created_at.as_json,
                updated_at: unverified_user_report.updated_at.as_json
              }
            ]
          )
        )
      end

      include_examples 'presents pagination meta'

      let(:verified_user) { create :verified_user }
      let(:unverified_user) { create :user }
    end

    context 'when cluster_id parameter given' do
      let!(:cluster1_report) { create :violation_report, reporter_id: cluster1_user.id }
      let!(:cluster2_report) { create :violation_report, reporter_id: cluster2_user.id }
      let!(:unclustered_report) { create :violation_report, reporter_id: unclustered_user.id }

      before do
        ViolationReport::Report.reindex
        get '/lapor/v1/reports', params: { cluster_id: cluster1.id }
      end

      it { expect(response).to have_http_status(:ok) }

      it 'presents violation reports created by users of the cluster only' do
        expect(json_response).to match(
          data: a_hash_including(
            reports: [
              { id: cluster1_report.id,
                reporter: {
                  id: cluster1_user.id,
                  email: cluster1_user.email,
                  full_name: cluster1_user.full_name,
                  avatar: cluster1_user.avatar,
                  verified: cluster1_user.verified
                },
                dimension_id: cluster1_report.dimension_id,
                title: cluster1_report.title,
                description: cluster1_report.description,
                created_at: cluster1_report.created_at.as_json,
                updated_at: cluster1_report.updated_at.as_json
              }
            ]
          )
        )
      end

      include_examples 'presents pagination meta'

      let(:cluster1_user) { create :clustered_user }
      let(:cluster2_user) { create :clustered_user }
      let(:unclustered_user) { create :user }
      let(:cluster1) { cluster1_user.cluster }
    end
  end

  describe 'GET /v1/reports/{id}' do
    before { get "/lapor/v1/reports/#{report.to_param}" }

    it { expect(response).to have_http_status(:ok) }

    it 'presents violation report' do
      expect(json_response).to match(
        data: a_hash_including(
          report: {
            id: report.id,
            reporter: {
              id: reporter.id,
              email: reporter.email,
              full_name: reporter.full_name,
              avatar: reporter.avatar,
              verified: reporter.verified
            },
            dimension_id: report.dimension_id,
            title: report.title,
            description: report.description,
            created_at: report.created_at.as_json,
            updated_at: report.updated_at.as_json,
            detail: {
              id: detail.id,
              location: detail.location,
              occurrence_time: detail.occurrence_time.as_json,
              reportee: reportee.slice(%i[id name address telephone_number]),
              witnesses: detail.witnesses.as_json(only: %i[id name address telephone_number]),
              evidences: detail.evidences.map { |evidence| evidence.slice(:id, :file).as_json }
            }
          }
        )
      )
    end

    let(:reporter) { create :user }
    let(:report) { create :violation_report, reporter_id: reporter.id }
    let(:detail) { report.detail }
    let(:reportee) { detail.reportee }
  end

  describe 'POST /v1/reports' do
    it { expect { action }.to change(ViolationReport::Report, :count).by(1) }

    it 'responds with status code :created (201)' do
      action
      expect(response).to have_http_status(:created)
    end

    it 'presents the newly created violation report' do
      action

      expect(json_response).to match(
        data: a_hash_including(
          report: {
            id: created_report.id,
            reporter: {
              id: reporter.id,
              email: reporter.email,
              full_name: reporter.full_name,
              avatar: reporter.avatar,
              verified: reporter.verified
            },
            dimension_id: created_report.dimension_id,
            title: created_report.title,
            description: created_report.description,
            created_at: created_report.created_at.as_json,
            updated_at: created_report.updated_at.as_json,
            detail: {
              id: created_detail.id,
              location: created_detail.location,
              occurrence_time: created_detail.occurrence_time.as_json,
              reportee: created_reportee.slice(%i[id name address telephone_number]),
              witnesses: created_detail.witnesses.as_json(only: %i[id name address telephone_number]),
              evidences: created_detail.evidences.map { |evidence| evidence.slice(:id, :file).as_json }
            }
          }
        )
      )
    end

    context 'with invalid parameters' do
      it { expect { action }.not_to change(ViolationReport::Report, :count) }

      it 'responds with status code :unprocessable_entity (422)' do
        action
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'presents error' do
        action

        expect(json_response).to match(
          error: a_hash_including(
            code: 422,
            errors: ["Validation failed: Title can't be blank"]
          )
        )
      end

      let(:params) { super().merge(title: '') }
    end

    context 'when unauthorized' do
      it { expect { action }.not_to change(ViolationReport::Report, :count) }

      it 'responds with status code :unauthorized (401)' do
        action
        expect(response).to have_http_status(:unauthorized)
      end

      let(:headers) { nil }
    end

    let(:reporter) { create :user }
    let(:headers) { stub_auth_headers user: reporter }
    let(:new_report) { build :violation_report }
    let(:new_detail) { new_report.detail }
    let(:new_reportee) { new_detail.reportee }
    let(:created_report) { ViolationReport::Report.recent.first! }
    let(:created_detail) { created_report.detail }
    let(:created_reportee) { created_detail.reportee }

    let(:params) {
      { dimension_id: new_report.dimension_id,
        title: new_report.title,
        description: new_report.description,
        location: new_detail.location,
        occurrence_time: new_detail.occurrence_time.as_json,
        reportee_name: new_reportee.name,
        reportee_address: new_reportee.address,
        reportee_telephone_number: new_reportee.telephone_number,
        witnesses: new_detail.witnesses.as_json(only: %i[name address telephone_number]),
        evidences: [fixture_file_upload('spec/images/html.png', 'image/png')]
      }
    }

    def action
      post '/lapor/v1/reports', headers: headers, params: params
    end
  end

  describe 'DELETE /v1/reports/{id}' do
    shared_examples 'successful deletion' do
      it { expect(ViolationReport::Report).not_to be_exists(report.id) }
      it { expect(response).to have_http_status(:ok) }
      it { expect(json_response).to match(data: a_hash_including(success: true)) }
    end

    context 'when authorized as admin' do
      before { action by: build(:admin) }

      include_examples 'successful deletion'
    end

    context 'when authorized as the reporter' do
      before { action by: reporter }

      include_examples 'successful deletion'
    end

    context 'when authorized not as admin nor the reporter' do
      before { action by: build(:user) }

      it { expect(ViolationReport::Report).to be_exists(report.id) }
      it { expect(response).to have_http_status(:forbidden) }
    end

    context 'when unauthorized' do
      before { action by: nil }

      it { expect(ViolationReport::Report).to be_exists(report.id) }
      it { expect(response).to have_http_status(:unauthorized) }
    end

    let(:reporter) { build :user }
    let(:report) { create :violation_report, reporter_id: reporter.id }

    def action(by:)
      headers = by ? stub_auth_headers(user: by) : nil
      delete "/lapor/v1/reports/#{report.to_param}", headers: headers
    end
  end
end