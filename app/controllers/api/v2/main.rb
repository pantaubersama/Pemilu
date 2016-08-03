require "grape-swagger"
module API
  module V2
    class Main < Grape::API
      use Grape::Middleware::Logger, {
          logger: Logger.new(STDERR)
      }
      mount API::V2::HelloWorlds::Routes

      # swagger settings
      options = {version: "v2"}
      add_swagger_documentation(
          api_version:             options[:version],
          doc_version:             options[:version],
          hide_documentation_path: true,
          mount_path:              "documentation/#{options[:version]}/doc",
          hide_format:             true
      )
    end
  end
end