require 'rails_helper'

describe API::V1::Lapor::ViolationReports::Resources::Reports do
  let(:access_token) { SecureRandom.hex }

  describe 'list' do
    it 'presents list of violation reports' do
      get '/dashboard/v1/lapor'
      expect(response).to have_http_status(:ok)

      expect(json_response).to match(
        data: a_hash_including(
          reports: [recent_report, earlier_report].map { |report|
            { id: report.id,
              reporter_id: report.reporter_id,
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

    let!(:earlier_report) { create :violation_report, created_at: '2000-01-01' }
    let!(:recent_report) { create :violation_report, created_at: '2000-01-02' }
  end

  describe 'detail' do
    it 'presents a violation report' do
      get "/dashboard/v1/lapor/#{report.to_param}"
      expect(response).to have_http_status(:ok)

      expect(json_response).to match(
        data: a_hash_including(
          report: {
            id: report.id,
            reporter_id: report.reporter_id,
            dimension_id: report.dimension_id,
            title: report.title,
            description: report.description,
            created_at: report.created_at.as_json,
            updated_at: report.updated_at.as_json,
            detail: {
              location: detail.location,
              occurrence_time: detail.occurrence_time.as_json,
              reportee: reportee.slice(%i[name address telephone_number]),
              witnesses: detail.witnesses.map { |witness| witness.slice(%i[name address telephone_number]) },
              evidences: detail.evidences.map { |evidence| evidence.slice(:file).as_json }
            }
          }
        )
      )
    end

    let!(:report) { create :violation_report }
    let(:detail) { report.detail }
    let(:reportee) { detail.reportee }
  end

  describe 'create' do
    context 'when authorized' do
      it { expect { action }.to change(ViolationReport::Report, :count).by(1) }

      it 'respond with status code :created (201)' do
        action
        expect(response).to have_http_status(:created)
      end

      it 'presents a violation report' do
        action

        expect(json_response).to match(
          data: a_hash_including(
            report: {
              id: created_report.id,
              reporter_id: created_report.reporter_id,
              dimension_id: created_report.dimension_id,
              title: created_report.title,
              description: created_report.description,
              created_at: created_report.created_at.as_json,
              updated_at: created_report.updated_at.as_json,
              detail: {
                location: created_detail.location,
                occurrence_time: created_detail.occurrence_time.as_json,
                reportee: created_reportee.slice(%i[name address telephone_number]),
                witnesses: created_detail.witnesses.map { |witness| witness.slice(%i[name address telephone_number]) },
                evidences: created_detail.evidences.map { |evidence| evidence.slice(:file).as_json }
              }
            }
          )
        )
      end

      let(:new_report) { build :violation_report }
      let(:new_detail) { new_report.detail }
      let(:new_reportee) { new_detail.reportee }
      let(:created_report) { ViolationReport::Report.recent.first! }
      let(:created_detail) { created_report.detail }
      let(:created_reportee) { created_detail.reportee }

      let(:valid_params) {
        { dimension_id: new_report.dimension_id,
          title: new_report.title,
          description: new_report.description,
          location: new_detail.location,
          occurrence_time: new_detail.occurrence_time.as_json,
          reportee_name: new_reportee.name,
          reportee_address: new_reportee.address,
          reportee_telephone_number: new_reportee.telephone_number,
          witnesses: new_detail.witnesses.map { |witness| witness.slice(%i[name address telephone_number]) },
          evidences: [fixture_file_upload('spec/images/html.png', 'image/png')]
        }
      }

      let(:invalid_params) { valid_params.merge(title: '') }

      def action
        post '/dashboard/v1/lapor', headers: stub_admin_auth_headers(access_token), params: valid_params
      end
    end

    context 'when unauthorized' do
      it { expect { action }.not_to change(ViolationReport::Report, :count) }

      it 'respond with status code :unauthorized (401)' do
        action
        expect(response).to have_http_status(:unauthorized)
      end

      def action
        post '/dashboard/v1/lapor'
      end
    end
  end

  describe 'delete' do
    context 'when authorized' do
      before { delete "/dashboard/v1/lapor/#{report.to_param}", headers: stub_admin_auth_headers(access_token) }

      it { expect(ViolationReport::Report).not_to be_exists(report.id) }
      it { expect(response).to have_http_status(:ok) }
      it { expect(json_response).to match(data: { success: true }) }
    end

    context 'when unauthorized' do
      before { delete "/dashboard/v1/lapor/#{report.to_param}" }

      it { expect(ViolationReport::Report).to be_exists(report.id) }
      it { expect(response).to have_http_status(:unauthorized) }
    end

    let!(:report) { create :violation_report }
  end
end