class API::V1::Linimasa::Feeds::Resources::Feeds < API::V1::ApplicationResource
  helpers API::V1::Helpers
  helpers API::V1::SharedParams

  resource "feeds" do
    desc "List feed pilpres", headers: OPTIONAL_AUTHORIZATION_HEADERS
    optional_oauth2
    params do
      use :filter, filter_by: ["", "team_all", "team_id_1", "team_id_2"]
      optional :q, type: String
    end
    paginate per_page: Pagy::VARS[:items], max_per_page: Pagy::VARS[:max_per_page]
    get :pilpres do
      query = "*"
      if params.q.present?
        query = "#{params.q}"
      end
      build_conditions = params.filter_by.present? ? team_filter(params.filter_by) : {}
      resources        = Feed.search(query, match: :text_middle, misspellings: false, page: params.page, per_page: params.per_page, order: { created_at: :desc }, where: build_conditions)

      present :feeds, resources, with: API::V1::Linimasa::Feeds::Entities::Feed
      present_metas_searchkick resources
    end

    desc "Detail feed pilpres", headers: AUTHORIZATION_HEADERS
    optional_oauth2
    params do
      requires :id
    end
    get "pilpres/:id" do
      resource = Feed.find(params.id)
      present :feed, resource, with: API::V1::Linimasa::Feeds::Entities::Feed
    end

    desc "List trash feeds", headers: AUTHORIZATION_HEADERS
    oauth2
    paginate per_page: Pagy::VARS[:items], max_per_page: Pagy::VARS[:max_per_page]
    get :trashes do
      authorize_admin!
      feeds = Feed.deleted
      resources = paginate(feeds)
      present :feeds, resources, with: API::V1::Linimasa::Feeds::Entities::Feed
      present_metas resources
    end

    desc "Detail trash pilpres", headers: AUTHORIZATION_HEADERS
    optional_oauth2
    params do
      requires :id
    end
    get "trash/:id" do
      resource = Feed.deleted.find(params.id)
      present :feed, resource, with: API::V1::Linimasa::Feeds::Entities::Feed
    end

    desc "Delete Feed", headers: AUTHORIZATION_HEADERS
    oauth2
    params do
      requires :id, type: String
    end
    delete do
      authorize_admin!
      feed = Feed.find(params.id)
      unless feed.delete
        error!(feed.errors.full_messages.join(", "), 422)
      end
      response = { message: "Feed id #{params.id} berhasil dihapus" }
      present response
    end

  end
end
