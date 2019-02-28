module API::V1::Hitung::Images::Entities
  class Image < API::V1::ApplicationEntity
    expose :id
    expose :file
    expose :hitung_real_count_id
    expose :image_type
  end
end
