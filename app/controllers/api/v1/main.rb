require "grape-swagger"
module API
  module V1
    class Main < Grape::API
      use Grape::Middleware::Logger, {
          logger: Logger.new(STDERR)
      }
      mount API::V1::HelloWorlds::Routes

      # swagger settings
      options = {version: "v1"}
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