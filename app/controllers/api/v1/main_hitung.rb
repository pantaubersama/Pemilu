require "grape-swagger"
module API
  module V1
    class MainHitung < Grape::API
      # Default Config API
      include API::V1::Config

      # Exception Handlers
      include API::V1::ExceptionHandlers

      mount API::V1::Hitung::Provinces::Routes
      mount API::V1::Hitung::Regencies::Routes
      mount API::V1::Hitung::Districts::Routes
      mount API::V1::Hitung::Villages::Routes
      mount API::V1::Hitung::Dapils::Routes

      mount API::V1::Hitung::RealCounts::Routes
      mount API::V1::Hitung::Images::Routes
      mount API::V1::Hitung::FormC1::Routes
      mount API::V1::Hitung::Candidates::Routes
      mount API::V1::Hitung::UnduhData::Routes
      mount API::V1::Hitung::Calculations::Routes

      mount API::V1::Hitung::Summary::Routes


      # Swagger config
      add_swagger_documentation(
          array_use_braces: true,
          api_version:             'not set',
          doc_version:             'not set',
          hide_documentation_path: true,
          mount_path:              "doc/api",
          hide_format:             true,
          info: {
              title: "Modul Hitung",
              description: "Modul Hitung"
          }
      )
    end
  end
end
