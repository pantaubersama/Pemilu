module API::V1::Hitung::Candidates
  class Routes < Grape::API
    formatter :json, ::API::SuccessFormatter
    error_formatter :json, ::API::ErrorFormatter

    mount API::V1::Hitung::Candidates::Resources::Candidates
  end
end
