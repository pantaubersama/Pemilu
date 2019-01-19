class API::V1::Linimasa::JanjiPolitiks::Resources::JanjiPolitiks < API::V1::ApplicationResource
  helpers API::V1::Helpers
  helpers API::V1::SharedParams

  resource "janji_politiks" do
    desc "List janji politiks", headers: OPTIONAL_AUTHORIZATION_HEADERS
    optional_oauth2
    params do
      optional :q, type: String
      optional :cluster_id, type: String, desc: "Cluster ID"
      use :filter, filter_by: ["", "user_verified_all", "user_verified_true", "user_verified_false"]
    end
    paginate per_page: Pagy::VARS[:items], max_per_page: Pagy::VARS[:max_per_page]
    get do
      query = "*"
      if params.q.present?
        query = "#{params.q}"
      end
      build_conditions = params.filter_by.present? ? question_filter(params.filter_by) : {}
      if params.cluster_id.present?
        build_conditions = build_conditions.merge({ cluster_id: params.cluster_id })
      end
      default_order = {created_at: {order: :desc, unmapped_type: "long"}}

      resources = JanjiPolitik.search(query, match: :text_middle, misspellings: false, load: false, page: (params.page || 1), per_page: (params.per_page || Pagy::VARS[:items]), order: default_order, where: build_conditions)

      present :janji_politiks, resources, with: API::V1::Linimasa::JanjiPolitiks::Entities::JanjiPolitik
      present_metas_searchkick resources
    end

    desc "List me janji politiks", headers: OPTIONAL_AUTHORIZATION_HEADERS
    optional_oauth2
    params do
      optional :q, type: String
    end
    paginate per_page: Pagy::VARS[:items], max_per_page: Pagy::VARS[:max_per_page]
    get :me do
      query = "*"
      if params.q.present?
        query = "#{params.q}"
      end
      default_order = {created_at: {order: :desc, unmapped_type: "long"}}
      resources = JanjiPolitik.search(query, match: :text_middle, misspellings: false, load: false, page: (params.page || 1), per_page: (params.per_page || Pagy::VARS[:items]), order: default_order, where: { user_id: current_user.id })

      present :janji_politiks, resources, with: API::V1::Linimasa::JanjiPolitiks::Entities::JanjiPolitik
      present_metas_searchkick resources
    end

    desc "List trash politiks", headers: AUTHORIZATION_HEADERS
    oauth2
    paginate per_page: Pagy::VARS[:items], max_per_page: Pagy::VARS[:max_per_page]
    get :trashes do
      authorize_admin!
      politiks  = JanjiPolitik.deleted
      resources = paginate(politiks)
      present :politiks, resources, with: API::V1::Linimasa::JanjiPolitiks::Entities::JanjiPolitik
      present_metas resources
    end

    desc "Detail trash politiks", headers: AUTHORIZATION_HEADERS
    oauth2
    params do
      requires :id
    end
    get "trash/:id" do
      resource = JanjiPolitik.deleted.find(params.id)
      present :politiks, resource, with: API::V1::Linimasa::JanjiPolitiks::Entities::JanjiPolitik
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

    desc "Update Janji Politik" do
      detail "Update Janji Politik"
      headers AUTHORIZATION_HEADERS
    end
    params do
      optional :title, type: String
      optional :body, type: String
      optional :image, type: File
    end
    oauth2
    put "/:id" do
      authorize_admin!
      params[:image] = prepare_file(params[:image]) if params[:image].present?
      q              = JanjiPolitik.find params.id
      status         = q.update_attributes(janji_params)
      present :status, status
      present :janji_politik, q, with: API::V1::Linimasa::JanjiPolitiks::Entities::JanjiPolitik
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
    desc "Detail janji politiks", headers: OPTIONAL_AUTHORIZATION_HEADERS
    optional_oauth2
    params do
      requires :id
    end
    get "/:id" do
      resource = JanjiPolitik.find(params.id)
      present :janji_politik, resource, with: API::V1::Linimasa::JanjiPolitiks::Entities::JanjiPolitik
    end
  end

  helpers do
    def janji_params
      permitted_params(params.except(:access_token)).permit(:id, :title, :body, :image)
    end
  end

end
