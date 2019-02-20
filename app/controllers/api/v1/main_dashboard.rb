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
      mount API::V1::Dashboard::BannerInfos::Routes
      mount API::V1::Dashboard::Quizzes::Routes
      mount API::V1::Dashboard::Questions::Routes
      mount API::V1::Dashboard::AppVersions::Routes
      mount API::V1::Dashboard::Home::Routes
      mount API::V1::Dashboard::QuestionsActions::Routes
      mount API::V1::Dashboard::Votes::Routes


      # Swagger config
      add_swagger_documentation(
          api_version:             'not set',
          doc_version:             'not set',
          hide_documentation_path: true,
          mount_path:              "doc/api",
          hide_format:             true,
          array_use_braces:        true,
          info: {
              title: "Modul Dashboard",
              description: "Modul Dashboard"
          }
      )
    end
  end
end
