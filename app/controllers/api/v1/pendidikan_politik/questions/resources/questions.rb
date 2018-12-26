module API::V1::PendidikanPolitik::Questions::Resources
  class Questions < API::V1::ApplicationResource
    helpers API::V1::Helpers
    helpers API::V1::SharedParams

    resource "questions" do
      desc "List question" do
        detail "List question"
      end
      paginate per_page: 25, max_per_page: 500
      params do
        use :order, order_by: %i(created cached_votes_up), default_order_by: :created, default_order: :desc
        use :filter, filter_by: %i(user_verified_all user_verified_true user_verified_false)
      end
      get "/" do
        default_order = {created: :desc}
        build_order = params.order_by.present? && params.direction.present? ? { params.order_by.to_sym => params.direction.to_sym } : default_order

        default_conditions = {}
        build_conditions = params.filter_by.present? ? question_filter(params.filter_by) : default_conditions

        resources = Question.search("*", load: false, page: params.page, per_page: params.per_page, order: build_order, where: build_conditions).results
        present :questions, resources, with: API::V1::PendidikanPolitik::Questions::Entities::Question, index_version: true
        present_metas resources
      end

      desc "Create a question" do
        detail "Create a question"
        headers AUTHORIZATION_HEADERS
        params API::V1::PendidikanPolitik::Questions::Entities::Question.documentation
      end
      oauth2
      post "/" do
        params[:user_id] = current_user.id
        q = Question.new question_params
        status = q.save!
        present :status, status
        present :question, q, with: API::V1::PendidikanPolitik::Questions::Entities::Question
      end

      desc "Show a question" do
        detail "Show a question"
      end
      params do
        requires :id
      end
      get "/:id" do
        q = Question.find params[:id]
        present :question, q, with: API::V1::PendidikanPolitik::Questions::Entities::Question
      end

      desc "Delete a question" do
        detail "Delete a question"
        headers AUTHORIZATION_HEADERS
      end
      params do
        requires :id
      end
      oauth2
      delete "/" do
        q = Question.find_by id: params[:id], user_id: current_user.id

        error!("ID not found : #{params.id}", 404) unless q

        del = q.destroy!

        present :question, q, with: API::V1::PendidikanPolitik::Questions::Entities::Question
        present :status, q.paranoia_destroyed?
      end

    end

    # permitted params
    helpers do
      def question_params
        permitted_params(params.except(:access_token)).permit(:body, :user_id)
      end
    end
  end
end
