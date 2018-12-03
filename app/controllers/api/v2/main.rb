require "grape-swagger"
module API
  module V2
    class Main < Grape::API
      # Default Config API
      include API::V2::Config

      # Mounting Modules Api
      mount API::V2::Adventures::Routes

      # Swagger config
      add_swagger_documentation(
        api_version:             'v2',
        doc_version:             'v2',
        hide_documentation_path: true,
        mount_path:              "doc/api",
        hide_format:             true
      )
    end
  end
end