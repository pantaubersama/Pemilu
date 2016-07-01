module API
  module V1
    module HelloWorlds
      class Routes < Grape::API
        mount API::V1::HelloWorlds::Resources::HelloWorlds
      end
    end
  end
end
