module API
  module V2
    module HelloWorlds
      class Routes < Grape::API
        mount API::V2::HelloWorlds::Resources::HelloWorlds
      end
    end
  end
end
