class API::V1::Teams::Entities::Team < Grape::Entity
  expose :id
  expose :title
  expose :avatar
end