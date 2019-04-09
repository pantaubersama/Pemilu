class API::V1::Hitung::Districts::Entities::District < Grape::Entity
  expose :id
  expose :code
  expose :regency_code
  expose :name
  expose :id_parent
  expose :id_wilayah
  expose :level
end
