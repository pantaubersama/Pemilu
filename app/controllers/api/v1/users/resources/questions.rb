module API::V1::Users::Resources
  class Questions < API::V1::ApplicationResource
    helpers API::V1::Helpers
    helpers API::V1::SharedParams

    resource "users" do

      desc "User Question" do
        detail "User Question"
        OPTIONAL_AUTHORIZATION_HEADERS
      end
      paginate per_page: Pagy::VARS[:items], max_per_page: Pagy::VARS[:max_per_page]
      params do
        use :searchkick_search, default_m: :word_start, default_o: "and"
        use :order, order_by: [:created_at, :cached_votes_up], default_order_by: :created_at, default_order: :desc
        use :filter, filter_by: %i(user_verified_all user_verified_true user_verified_false)
      end
      optional_oauth2
      get "/:id/questions" do
        user = User.find params.id

        q = params.q.nil? || params.q.empty? ? "*" : params.q
        operator = params.o.nil? || params.o.empty? ? "and" : params.o
        match_word = params.m.nil? || params.m.empty? ? :word_start : params.m.to_sym

        default_order = {created_at: {order: :desc, unmapped_type: "long"}}
        build_order = params.order_by.present? && params.direction.present? ? { params.order_by.to_sym => { order: params.direction.to_sym, unmapped_type: "long"  } } : default_order

        default_conditions = { "user.id" => user.id }
        build_conditions = params.filter_by.present? ? question_filter(params.filter_by) : default_conditions

        resources = Question.search(q, operator: operator, match: match_word, misspellings: false,
          load: false, page: (params.page || 1), per_page: (params.per_page || Pagy::VARS[:items]), order: build_order, where: build_conditions)
        liked_resources = ActsAsVotable::Vote.where(votable_type: "Question", votable_id: resources.map(&:id), voter_id: current_user.id, vote_flag: true, vote_scope: nil).map(&:votable_id) if current_user.present?
        reported_resources = ActsAsVotable::Vote.where(votable_type: "Question", votable_id: resources.map(&:id), voter_id: current_user.id, vote_flag: false, vote_scope: "report").map(&:votable_id) if current_user.present?
        present :questions, resources, with: API::V1::PendidikanPolitik::Questions::Entities::Question, index_version: true, liked_resources: liked_resources, reported_resources: reported_resources
        present_metas_searchkick resources
      end

    end
  end
end