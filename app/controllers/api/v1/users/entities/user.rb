class API::V1::Users::Entities::User < Grape::Entity
  expose :id
  expose :email
  expose :first_name
  expose :last_name
end