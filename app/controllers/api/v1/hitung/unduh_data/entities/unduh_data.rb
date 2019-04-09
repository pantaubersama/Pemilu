module API::V1::Hitung::UnduhData::Entities
  class UnduhData < Grape::Entity
    expose :id
    expose :name
    expose :email
    expose :organization
    expose :phone
    expose :necessity
  end
end
