class API::V1::Hitung::Infos::Resources::Infos < API::V1::ApplicationResource
  helpers API::V1::Helpers
  
  resource "infos" do
    desc "Test", headers: AUTHORIZATION_HEADERS
    oauth2 
    get :test do
      authenticate_user! request.headers["Authorization"].try(:split, " ").try(:last) || params[:access_token]
      present :hello,  current_user
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
