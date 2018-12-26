require "grape-swagger"
module API
  module V1
    class MainLinimasa < Grape::API
      # Default Config API
      include API::V1::Config

      # Exception Handlers
      include API::V1::ExceptionHandlers

      # Mounting Modules Api
      # mount API::V1::Adventures::Routes

      # Mounting Modules Api /linimasa
      # mount API::V1::Linimasa::Infos::Routes
      mount API::V1::Linimasa::Feeds::Routes
      mount API::V1::Linimasa::JanjiPolitiks::Routes


      # Swagger config
      add_swagger_documentation(
          api_version:             'not set',
          doc_version:             'not set',
          hide_documentation_path: true,
          mount_path:              "doc/api",
          hide_format:             true,
          info: {
              title: "Modul Linimasa",
              description: "Modul Linimasa"
          }
      )
    end
  end
end