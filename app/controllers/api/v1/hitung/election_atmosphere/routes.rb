module API::V1::Hitung::ElectionAtmosphere
  class Routes < Grape::API
    formatter :json, ::API::SuccessFormatter
    error_formatter :json, ::API::ErrorFormatter

    mount API::V1::Hitung::ElectionAtmosphere::Resources::ElectionAtmosphere
  end
end
