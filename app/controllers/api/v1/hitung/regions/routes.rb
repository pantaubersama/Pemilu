module API::V1::Hitung::Regions
  class Routes < Grape::API
    formatter :json, ::API::SuccessFormatter
    error_formatter :json, ::API::ErrorFormatter

    resource "regions" do
      mount API::V1::Hitung::Districts::Resources::Districts
      mount API::V1::Hitung::Regencies::Resources::Regencies
      mount API::V1::Hitung::Provinces::Resources::Provinces
      mount API::V1::Hitung::Villages::Resources::Villages
      mount API::V1::Hitung::Dapils::Resources::Dapils
    end
  end
end
