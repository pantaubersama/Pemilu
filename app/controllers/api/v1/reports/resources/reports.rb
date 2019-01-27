module API::V1::Reports::Resources
  class Reports < API::V1::ApplicationResource
    helpers API::V1::Helpers do
      params :reportable! do
        requires :id, type: String, desc: 'Reportable ID'
        requires :class_name, type: String, values: %w[Question ViolationReport::Report], desc: 'Reportable class name'
      end
    end

    resource "reports" do
      desc "Report something" do
        headers AUTHORIZATION_HEADERS
        detail "Report something"
      end
      params do
        use :reportable!
      end
      oauth2
      post "/" do
        question_must_not_in_folder!
        reportable.reported_by current_user
        present :vote, {status: reportable.vote_registered?}, with: API::V1::Reports::Entities::VoteRegistered
      end
    end

    helpers do
      def reportable
        @reportable ||= ::Kernel.const_get(params.class_name).find(params.id)
      end

      def question_must_not_in_folder!
        error!('Pertanyaan sudah terpilih', 404) if reportable.is_a?(Question) && reportable.question_folder_id.present?
      end
    end
  end
end