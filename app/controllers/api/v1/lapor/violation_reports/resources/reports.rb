class API::V1::Lapor::ViolationReports::Resources::Reports < API::V1::ApplicationResource
  ReportEntity = API::V1::Lapor::ViolationReports::Entities::ViolationReport::Report

  helpers API::V1::Helpers do
    params :id! do
      requires :id, type: String, desc: 'Violation report ID'
    end

    def report
      @report ||= ViolationReport::Report.find(params.id)
    end
  end

  resource :lapor do
    # GET /v1/lapor
    desc 'List violation reports'
    get do
      reports = paginate(ViolationReport::Report.recent)
      present :reports, reports, with: ReportEntity
      present_metas reports
    end

    # GET /v1/lapor/{id}
    desc 'Detail violation report'
    params do
      use :id!
    end
    get ':id' do
      present :report, report, with: ReportEntity, type: :full
    end

    # POST /v1/lapor
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
      report = ViolationReport::Report.create!( # DEV
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

    # DELETE /v1/lapor/{id}
    desc 'Delete violation report' do
      headers AUTHORIZATION_HEADERS
    end
    oauth2
    params do
      use :id!
    end
    delete ':id' do
      report.destroy!
      present :success, true
    end
  end
end
