module API
  module V1
    module Linimasa
      module JanjiPolitiks
        class Routes < Grape::API
          # Format response
          formatter :json, ::API::SuccessFormatter
          error_formatter :json, ::API::ErrorFormatter

          mount API::V1::Linimasa::JanjiPolitiks::Resources::JanjiPolitiks
        end
      end
    end
  end
end
