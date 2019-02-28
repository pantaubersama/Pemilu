class API::V1::Hitung::Regencies::Entities::Regency < Grape::Entity
  expose :id
  expose :province_id
  expose :code
  expose :name
  expose :level
  expose :domain_name
  expose :id_wilayah
  expose :id_parent
end
