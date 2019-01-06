class API::V1::Linimasa::JanjiPolitiks::Resources::JanjiPolitiks < API::V1::ApplicationResource
  helpers API::V1::Helpers
  helpers API::V1::SharedParams

  resource "janji_politiks" do
    desc "List janji politiks", headers: OPTIONAL_AUTHORIZATION_HEADERS
    optional_oauth2
    params do
      optional :q, type: String
      optional :cluster_id, type: String, desc: "Cluster ID"
      use :filter, filter_by: %i(user_verified_all user_verified_true user_verified_false)
    end
    paginate per_page: 100, max_per_page: 500
    get do
      query = "*"
      if params.q.present?
        query = "#{params.q}"
      end
      build_conditions = params.filter_by.present? ? question_filter(params.filter_by) : {}
      if params.cluster_id.present?
        build_conditions = build_conditions.merge({ cluster: params.cluster_id })
      end

      resources = JanjiPolitik.search(query, match: :text_middle, misspellings: false, load: true, page: params.page, per_page: params.per_page, order: { created_at: :desc }, where: build_conditions).results

      present :janji_politiks, resources, with: API::V1::Linimasa::JanjiPolitiks::Entities::JanjiPolitik
      present_metas resources
    end

    desc "List me janji politiks", headers: OPTIONAL_AUTHORIZATION_HEADERS
    optional_oauth2
    params do
      optional :q, type: String
    end
    paginate per_page: 100, max_per_page: 500
    get :me do
      query = "*"
      if params.q.present?
        query = "#{params.q}"
      end
      resources = JanjiPolitik.search(query, match: :text_middle, misspellings: false, load: true, page: params.page, per_page: params.per_page, order: { created_at: :desc }, where: {user_id: current_user.id}).results

      present :janji_politiks, resources, with: API::V1::Linimasa::JanjiPolitiks::Entities::JanjiPolitik
      present_metas resources
    end

    desc "Create janji politiks", headers: AUTHORIZATION_HEADERS
    oauth2
    params do
      requires :title, type: String
      requires :body, type: String
      optional :image, type: File
    end
    post do
      authorize_eligible_user!
      resources = JanjiPolitik.new(params.merge({ user_id: current_user.id }))
      unless resources.save
        error!(resources.errors.full_messages.join(", "), 422)
      end
      present :janji_politik, resources, with: API::V1::Linimasa::JanjiPolitiks::Entities::JanjiPolitik
    end

    desc "Update image janji politiks", headers: AUTHORIZATION_HEADERS
    oauth2
    params do
      requires :id, type: String, desc: "Janji Politik ID"
      requires :image, type: File
    end
    put :image do
      authorize_eligible_user!
      resource       = JanjiPolitik.find_by(id: params.id, user_id: current_user.id)
      resource.image = params.image
      unless resource.save
        error!(resource.errors.full_messages.join(", "), 422)
      end
      present :janji_politik, resource, with: API::V1::Linimasa::JanjiPolitiks::Entities::JanjiPolitik
    end

    desc "Delete janji politiks", headers: AUTHORIZATION_HEADERS
    oauth2
    params do
      requires :id, type: String
    end
    delete do
      authorize_eligible_user!
      resources = JanjiPolitik.find_by(id: params.id, user_id: current_user.id)
      unless resources.delete
        error!(resources.errors.full_messages.join(", "), 422)
      end
      response = { message: "Janji Politik id `#{params.id}` berhasil dihapus" }
      present response
    end
  end
end
