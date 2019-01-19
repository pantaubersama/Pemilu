module API::V1::PendidikanPolitik::Questions::Resources
  class Questions < API::V1::ApplicationResource
    helpers API::V1::Helpers
    helpers API::V1::SharedParams

    resource "questions" do
      desc "List question" do
        detail "List question"
        headers OPTIONAL_AUTHORIZATION_HEADERS
      end
      paginate per_page: Pagy::VARS[:items], max_per_page: Pagy::VARS[:max_per_page]
      params do
        use :searchkick_search, default_m: :word_start, default_o: "and"
        use :order, order_by: [:created_at, :cached_votes_up], default_order_by: :created_at, default_order: :desc
        use :filter, filter_by: %i(user_verified_all user_verified_true user_verified_false)
      end
      optional_oauth2
      get "/" do
        q = params.q.nil? || params.q.empty? ? "*" : params.q
        operator = params.o.nil? || params.o.empty? ? "and" : params.o
        match_word = params.m.nil? || params.m.empty? ? :word_start : params.m.to_sym

        default_order = {created_at: :desc}
        build_order = params.order_by.present? && params.direction.present? ? { params.order_by.to_sym => params.direction.to_sym } : default_order

        default_conditions = {}
        build_conditions = params.filter_by.present? ? question_filter(params.filter_by) : default_conditions

        resources = Question.search(q, operator: operator, match: match_word, misspellings: false,
          load: false, page: (params.page || 1), per_page: (params.per_page || Pagy::VARS[:items]), order: build_order, where: build_conditions)
        liked_resources = ActsAsVotable::Vote.where(votable_type: "Question", votable_id: resources.map(&:id), voter_id: current_user.id, vote_flag: true, vote_scope: nil).map(&:votable_id) if current_user.present?
        reported_resources = ActsAsVotable::Vote.where(votable_type: "Question", votable_id: resources.map(&:id), voter_id: current_user.id, vote_flag: false, vote_scope: "report").map(&:votable_id) if current_user.present?
        present :questions, resources, with: API::V1::PendidikanPolitik::Questions::Entities::Question, index_version: true, liked_resources: liked_resources, reported_resources: reported_resources
        present_metas_searchkick resources
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
        headers OPTIONAL_AUTHORIZATION_HEADERS
      end
      params do
        requires :id
      end
      optional_oauth2
      get "/:id" do
        q = Question.not_in_folder.find params[:id]
        liked_resources = ActsAsVotable::Vote.where(votable_type: "Question", votable_id: q.id, voter_id: current_user.id, vote_flag: true, vote_scope: nil).map(&:votable_id) if current_user.present?
        reported_resources = ActsAsVotable::Vote.where(votable_type: "Question", votable_id: q.id, voter_id: current_user.id, vote_flag: false, vote_scope: "report").map(&:votable_id) if current_user.present?
        present :question, q, with: API::V1::PendidikanPolitik::Questions::Entities::Question, liked_resources: liked_resources, reported_resources: reported_resources
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
        q = Question.not_in_folder.find_by id: params[:id], user_id: current_user.id

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
