module API
  module V1
    module Config
      extend ActiveSupport::Concern
      included do
        version "v1", using: :header, vendor: 'mnpix'
        default_format :json
        format :json
        formatter :json, API::V1::SuccessFormatter
        error_formatter :json, API::V1::ErrorFormatter


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
