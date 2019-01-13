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
      resources        = Feed.search(query, match: :text_middle, misspellings: false, load: true, page: params.page, per_page: params.per_page, order: { created_at: :desc }, where: build_conditions)

      present :feeds, resources, with: API::V1::Linimasa::Feeds::Entities::Feed
      present_metas_searchkick resources
    end
  end
end
