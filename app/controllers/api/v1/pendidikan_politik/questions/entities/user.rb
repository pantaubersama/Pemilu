module API::V1::PendidikanPolitik::Questions::Entities
  class User < Grape::Entity
    expose :id
    expose :email
    expose :full_name
    expose :username
    expose :avatar
    expose :verified
    expose :about
  end
end