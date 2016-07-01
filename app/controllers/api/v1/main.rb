module API
  module V1
    class Main < Grape::API
      mount API::V1::HelloWorlds::Routes
    end
  end
end