module API
  module V1
    class ApplicationResource < Grape::API
      # Helpers
      helpers API::V1::Helpers

      # Exception Handlers
      include API::V1::ExceptionHandlers

      AUTHORIZATION_HEADERS = { Authorization: { description: 'Access Token', required: true } }.freeze
    end
  end
end
