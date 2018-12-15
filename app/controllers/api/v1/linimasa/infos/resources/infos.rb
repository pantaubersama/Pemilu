class API::V1::Linimasa::Infos::Resources::Infos < API::V1::ApplicationResource
  helpers API::V1::Helpers

  resource "infos" do
    desc "Version"
    get :version do
      results = { version: "v1" }
      present results
    end
    desc "Modul name"
    get do
      results = { name: "linimasa" }
      present results
    end
  end
end
