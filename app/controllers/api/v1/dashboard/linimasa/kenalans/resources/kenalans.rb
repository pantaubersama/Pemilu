class API::V1::Dashboard::Linimasa::Kenalans::Resources::Kenalans < API::V1::ApplicationResource
  helpers API::V1::Helpers

  resource "kenalans" do
    desc "List Kenalans", headers: AUTHORIZATION_HEADERS
    oauth2
    get do
      kenalans = Kenalan.all
      present :kenalans, kenalans, with: API::V1::Dashboard::Linimasa::Kenalans::Entities::Kenalan
    end

    desc "Update Kenalans", headers: AUTHORIZATION_HEADERS
    oauth2
    params do
      requires :id, type: String
      optional :link, type: String
      optional :text, type: String
    end
    put do
      kenalan = Kenalan.find(params.id)
      kenalan.update(params)
      present :kenalan, kenalan, with: API::V1::Dashboard::Linimasa::Kenalans::Entities::Kenalan
    end
  end
end
