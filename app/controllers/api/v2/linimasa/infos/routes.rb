module API::V2::Linimasa::Infos
  class Routes < Grape::API
    # Format response
    formatter :json, ::API::SuccessFormatter
    error_formatter :json, ::API::ErrorFormatter

    mount API::V2::Linimasa::Infos::Resources::Infos
  end
end
