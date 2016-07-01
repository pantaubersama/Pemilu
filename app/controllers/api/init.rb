module API
  class Init < Grape::API
    mount API::V1::Main
  end
end