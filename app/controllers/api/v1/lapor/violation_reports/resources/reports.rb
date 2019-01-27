class API::V1::Lapor::ViolationReports::Resources::Reports < API::V1::ApplicationResource
  ReportEntity = API::V1::Lapor::ViolationReports::Entities::ViolationReport::Report

  helpers API::V1::Helpers do
    params :id! do
      requires :id, type: String, desc: 'Violation report ID'
    end
  end

  resource :reports do
    # GET /v1/reports
    desc 'List violation reports'
    params do
      optional :q, type: String, desc: 'Search keyword'
      optional :cluster_id, type: String, desc: 'Filter by cluster ID'
      optional :verification, type: Symbol, values: %i[verified unverified], desc: 'Reporter verification status'
    end
    paginate per_page: Pagy::VARS[:items], max_per_page: Pagy::VARS[:max_per_page]
    get do
      conditions = {}
      conditions['reporter.cluster.id'] = params.cluster_id if params.cluster_id.present?
      conditions['reporter.verified'] = params.verification == :verified if params.verification.present?

      reports = ViolationReport::Report.search(
        params.q.presence || '*',
        match: :text_middle,
        misspellings: false,
        load: false,
        page: params.page || 1,
        per_page: params.per_page || Pagy::VARS[:items],
        order: { created_at: { order: :desc, unmapped_type: 'long' } },
        where: conditions
      )

      present :reports, reports, with: ReportEntity
      present_metas_searchkick reports
    end

    # GET /v1/reports/{id}
    desc 'Detail violation report'
    params do
      use :id!
    end
    get ':id' do
      present :report, report, with: ReportEntity, type: :full
    end

    # POST /v1/reports
    desc 'Create violation report' do
      headers AUTHORIZATION_HEADERS
    end
    oauth2
    params do
      requires :dimension_id, type: String, desc: 'Dimension ID'
      requires :title, type: String, desc: 'Title'
      requires :description, type: String, desc: 'Brief description'
      requires :location, type: String, desc: 'Scene'
      requires :occurrence_time, type: Time, desc: 'Occurrence time'
      requires :reportee_name, type: String, desc: 'Reportee name'
      requires :reportee_address, type: String, desc: 'Reportee address'
      optional :reportee_telephone_number, type: String, desc: 'Reportee telephone number'
      requires :witnesses, type: Array do
        requires :name, type: String, desc: 'Witness name'
        requires :address, type: String, desc: 'Witness address'
        requires :telephone_number, type: String, desc: 'Witness telephone number'
      end
      requires :evidences, type: Array[File], desc: <<~DESCRIPTION.squish!
        Evidences.<br>
        Maximum 800 KB each.<br>
        Allowed extensions are #{ViolationReportEvidenceFileUploader::ALLOWED_EXTENSIONS.to_sentence}.
      DESCRIPTION
    end
    post do
      report = ViolationReport::Report.create!(
        reporter_id: current_user.id,
        dimension_id: params.dimension_id,
        title: params.title,
        description: params.description,
        detail_attributes: {
          location: params.location,
          occurrence_time: params.occurrence_time,
          reportee_attributes: {
            name: params.reportee_name,
            address: params.reportee_address,
            telephone_number: params.reportee_telephone_number
          },
          witnesses_attributes: params.witnesses.map { |witness_params|
            { name: witness_params.name,
              address: witness_params.address,
              telephone_number: witness_params.telephone_number
            }
          },
          evidences_attributes: params.evidences.map { |file| { file: file } }
        }
      )

      present :report, report, with: ReportEntity, type: :full
    end

    # DELETE /v1/reports/{id}
    desc 'Delete violation report' do
      headers AUTHORIZATION_HEADERS
    end
    oauth2
    params do
      use :id!
    end
    delete ':id' do
      error!('Forbidden', 403) unless current_user.is_admin || current_user.id == report.reporter_id
      report.destroy!
      present :success, true
    end
  end

  helpers do
    def report
      ViolationReport::Report.find params.id
    end
  end
end
