module API
  module V2
    class ApplicationResource < Grape::API
      # Exception Handlers
      include API::V2::ExceptionHandlers
      AUTHORIZATION_HEADERS = { Authorization: { description: 'Access Token', required: true } }.freeze
    end
  end
end
