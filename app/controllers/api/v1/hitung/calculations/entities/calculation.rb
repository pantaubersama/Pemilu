module API::V1::Hitung::Calculations::Entities
  class Calculation < Grape::Entity
    expose :hitung_real_count_id
    expose :real_count, using: API::V1::Hitung::RealCounts::Entities::RealCount
    expose :calculation_type
    expose :id
    expose :invalid_vote
    expose :created_at_in_word
    expose :real_count, using: API::V1::Hitung::RealCounts::Entities::RealCount
    expose :details, as: :candidates, using: API::V1::Hitung::Calculations::Entities::Detail
  end
end
