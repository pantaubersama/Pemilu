class API::V1::Linimasa::Feeds::Resources::Feeds < API::V1::ApplicationResource
  helpers API::V1::Helpers

  resource "feeds" do
    desc "List feed pilpres", headers: AUTHORIZATION_HEADERS
    oauth2
    paginate per_page: 100, max_per_page: 500
    get :pilpres do
      resources = paginate(Feed.all)
      present :feeds, resources, with: API::V1::Linimasa::Feeds::Entities::Feed
      present_metas resources
    end
  end
end
