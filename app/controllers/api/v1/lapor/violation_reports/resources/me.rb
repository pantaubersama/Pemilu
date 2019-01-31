class API::V1::Lapor::ViolationReports::Resources::Me < API::V1::ApplicationResource
  ReportEntity = API::V1::Lapor::ViolationReports::Entities::ViolationReport::Report

  helpers API::V1::Helpers

  resource :me do
    # GET /v1/me/reports
    desc "List authorized user's violation reports" do
      headers AUTHORIZATION_HEADERS
    end
    oauth2
    paginate per_page: Pagy::VARS[:items], max_per_page: Pagy::VARS[:max_per_page]
    get :reports do
      reports = paginate(ViolationReport::Report.where(reporter_id: current_user.id).recent)
      present :reports, reports, with: ReportEntity
      present_metas reports
    end
  end
end
