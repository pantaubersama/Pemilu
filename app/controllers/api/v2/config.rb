module API
  module V2
    module Config
      def self.included(base)
        base.instance_eval do
          # Global config Grape
          default_format :json
          version 'v2', using: :path, vendor: 'mnpix'
          format :json
          content_type :json, 'application/json; charset=UTF-8'
        end
      end
    end
  end
end
