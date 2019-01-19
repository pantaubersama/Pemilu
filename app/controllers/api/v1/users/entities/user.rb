class API::V1::Users::Entities::User < Grape::Entity
  expose :id
  expose :email
  expose :full_name
  expose :username
  expose :about
  expose :avatar
  expose :cluster
  expose :verified
end