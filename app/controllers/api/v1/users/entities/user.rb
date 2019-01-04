class API::V1::Users::Entities::User < Grape::Entity
  expose :id
  expose :email
  expose :full_name
  expose :about
  expose :avatar
  expose :cluster
end