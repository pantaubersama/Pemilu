module API
  module V2
    module Config
      extend ActiveSupport::Concern
      included do
        version "v2", using: :header, vendor: 'mnpix'
        default_format :json
        format :json
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
