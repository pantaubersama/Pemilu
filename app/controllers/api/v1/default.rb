module API
  module V1
    module Default
      def self.included(base)
        base.instance_eval do
          # Global config Grape
          default_format :json
          version "v1", using: :param, parameter: 'v', vendor: 'mnpix'
          format :json
          content_type :json, 'application/json; charset=UTF-8'
        end
      end
    end
  end
end
