require "grape-swagger"
module API
  module V1
    class MainDashboard < Grape::API
      # Default Config API
      include API::V1::Config

      # Exception Handlers
      include API::V1::ExceptionHandlers

      # Mounting Modules Api
      # mount API::V1::Adventures::Routes

      # Mounting Modules Api /linimasa
      mount API::V1::Dashboard::Linimasa::Routes


      # Swagger config
      add_swagger_documentation(
          api_version:             'not set',
          doc_version:             'not set',
          hide_documentation_path: true,
          mount_path:              "doc/api",
          hide_format:             true
      )
    end
  end
end