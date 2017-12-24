require "grape-swagger"
module API
  module V2
    class Main < Grape::API
      use Grape::Middleware::Logger, {
        logger: Logger.new(STDERR)
      }
      mount API::V2::HelloWorlds::Routes
      add_swagger_documentation(
        api_version:             'v2',
        doc_version:             'v2',
        hide_documentation_path: true,
        mount_path:              "documentation/v2/doc",
        hide_format:             true
      )
    end
  end
end