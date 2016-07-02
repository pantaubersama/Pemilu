class API::V2::HelloWorlds::Resources::HelloWorlds < Grape::API
  include API::V2::Config
  resource "hello_worlds" do
    desc "Version"
    get "version" do
      results = {version: "v2"}
      present results
    end
    desc "Welcome"
    get "hello" do
      results = {messages: "Hello World"}
      present results
    end
    desc "Bye"
    get "bye" do
      error!("bye bye!", 404)
    end
  end
end
