class API::V1::Hitung::Infos::Resources::Infos < API::V1::ApplicationResource
  helpers API::V1::Helpers
  
  resource "infos" do
    desc "Test your token here!", headers: AUTHORIZATION_HEADERS
    oauth2
    get :test do
      present :token, the_access_token
      present :full_token, credentials
      present :cluster, current_user.cluster
      present :current_user, current_user
      present :current_user_id, current_user.id
    end

    desc "Version"
    get :version do
      results = { version: "v1" }
      present results
    end

    desc "Modul name"
    get do
      results = { name: "hitung" }
      present results
    end
  end
end
