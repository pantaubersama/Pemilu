require "grape-swagger"
module API
  module V1
    class MainLapor < Grape::API
      # Default Config API
      include API::V1::Config

      # Exception Handlers
      include API::V1::ExceptionHandlers

      # Mounting Modules Api /violation_reports
      mount API::V1::Lapor::ViolationReports::Routes


      # Swagger config
      add_swagger_documentation(
          api_version:             'not set',
          doc_version:             'not set',
          hide_documentation_path: true,
          mount_path:              "doc/api",
          hide_format:             true,
          array_use_braces:        true,
          info: {
              title: "Modul Lapor",
              description: "Modul Lapor"
          }
      )
    end
  end
end