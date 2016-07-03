class API::V2::HelloWorlds::Resources::HelloWorlds < Grape::API
  include API::V2::Config
  resource "hello_worlds" do
    desc "Version"
    get "version" do
      results = {version: "v2"}
      present results
    end
  end
end
