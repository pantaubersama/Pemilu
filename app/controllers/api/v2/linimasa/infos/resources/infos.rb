class API::V2::Linimasa::Infos::Resources::Infos < API::V2::ApplicationResource
  helpers API::V2::Helpers

  resource "infos" do
    desc "Version"
    get :version do
      results = { version: "v2" }
      present results
    end
    desc "Modul name"
    get do
      results = { name: "linimasa" }
      present results
    end
  end
end
