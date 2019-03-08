module API::V1::Hitung::ElectionAtmosphere::Entities
  class ElectionAtmosphere < Grape::Entity
    expose :id
    expose :file
    expose :image_type
    expose :hitung_real_count_id
    expose :real_count, with: API::V1::Hitung::ElectionAtmosphere::Entities::RealCount
  end
end
