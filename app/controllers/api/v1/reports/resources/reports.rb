module API::V1::Reports::Resources
  class Reports < API::V1::ApplicationResource
    helpers API::V1::Helpers

    resource "reports" do
      desc "Report something" do
        headers AUTHORIZATION_HEADERS
        detail "Report something"
      end
      params do
        requires :id, type: String, desc: "ID"
        requires :class_name, type: String, desc: "Your class name", documentation: {default: "Question"}
      end
      oauth2
      post "/" do
        klass = ::Kernel.const_get(params.class_name)
        q = klass.send(:find, params.id)

        if q.class.to_s == "Question"
          error!("Pertanyaan sudah terpilih", 404) if q.question_folder_id.present?
        end

        q.reported_by current_user
        present :vote, {status: q.vote_registered?}, with: API::V1::Reports::Entities::VoteRegistered
      end
    end
  end
end