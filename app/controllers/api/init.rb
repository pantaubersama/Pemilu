module API
  class Init < Grape::API
    mount API::V1::Main
    mount API::V2::Main
  end
end