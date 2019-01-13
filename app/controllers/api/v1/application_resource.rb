module API
  module V1
    class ApplicationResource < Grape::API
      # Exception Handlers
      include API::V1::ExceptionHandlers

      AUTHORIZATION_HEADERS = { Authorization: { description: 'Access Token', required: true } }.freeze
      OPTIONAL_AUTHORIZATION_HEADERS = { Authorization: { description: 'Access Token', required: false } }.freeze
    end
  end
end
