module API::V1::Hitung::Calculation
  class Routes < Grape::API
    # Format response
    formatter :json, ::API::SuccessFormatter
    error_formatter :json, ::API::ErrorFormatter

    resource 'calculation' do
      mount API::V1::Hitung::Images::Resources::Images
      mount API::V1::Hitung::FormC1::Resources::FormC1
    end
  end
end
