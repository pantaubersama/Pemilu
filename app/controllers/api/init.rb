module API
  class Init < Grape::API
    use Grape::Middleware::Logger

    mount API::V1::Main
    mount API::V2::Main
  end
end