class API::V1::Dashboard::Linimasa::Resources::Linimasa < API::V1::ApplicationResource
  helpers API::V1::Helpers
  resource "linimasa" do
    desc "Provides a simple, relevance-based search interface to public user accounts on Twitter. Try querying by topical interest, full name, company name, location, or other criteria. Exact match searches are not supported.Only the first 1,000 matching results are available."
    params do
      requires :q, type: String
      requires :page, type: Integer, default: 1
      requires :per_page, type: Integer, default: 100
    end
    get "twitter/username" do
      users = $twitter.user_search(params.q, { page: params.page, count: params.per_page })
      present :users, users, with: API::V1::Dashboard::Linimasa::Entities::Username
    end
  end
end
