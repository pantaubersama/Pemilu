module API
  module V2
    module Config
      extend ActiveSupport::Concern
      included do
        default_format :json
        version "v2", using: :accept_version_header, vendor: 'mnpix'
        format :json
        content_type :json, 'application/json; charset=UTF-8'
        formatter :json, API::V2::SuccessFormatter
        error_formatter :json, API::V2::ErrorFormatter

        rescue_from :all do |e|
          begin
            status = e.status
          rescue
            status = 500
          end
          error!(e, status)
        end
      end
    end
  end
end
