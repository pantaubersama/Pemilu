module API::V1::Hitung::ElectionAtmosphere::Entities
  class RealCount < Grape::Entity
    expose :id
    expose :tps, documentation: { type: Integer, values: (1..99).to_a, required: true }
    expose :province, using: API::V1::Hitung::Provinces::Entities::Province
    expose :regency, using: API::V1::Hitung::Regencies::Entities::Regency
    expose :district, using: API::V1::Hitung::Districts::Entities::District
    expose :village, using: API::V1::Hitung::Villages::Entities::Village
    expose :user, with: API::V1::Users::Entities::UserSimple
  end
end
