class API::V1::Users::Entities::UserSimple < Grape::Entity
  expose :id
  expose :email
  expose :full_name
  expose :avatar
  expose :verified
end