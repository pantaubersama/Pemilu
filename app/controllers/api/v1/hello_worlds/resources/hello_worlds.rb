class API::V1::HelloWorlds::Resources::HelloWorlds < Grape::API
  include API::V1::Config
  resource "hello_worlds" do
    desc "Welcome"
    get "welcome" do
      results = {messages: "Hello World"}
      present results
    end
    desc "Bye"
    get "bye" do
      error!("bye bye!", 404)
    end
  end
end
