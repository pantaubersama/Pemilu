class API::V2::HelloWorlds::Resources::HelloWorlds < Grape::API
  include API::V2::Config
  resource "hello_worlds" do
    desc "Version"
    params do
      optional :v, type: String, default: 'v2', values: ['v2'], description: "Documentation Version"
    end
    get "version" do
      results = {version: "v2"}
      present results
    end
  end
end
