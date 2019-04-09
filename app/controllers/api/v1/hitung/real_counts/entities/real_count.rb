module API::V1::Hitung::RealCounts::Entities
  class RealCount < API::V1::ApplicationEntity
    expose :id
    expose :tps, documentation: { type: Integer, values: (1..99).to_a, required: true }
    expose :province_code, documentation: { type: Integer, required: true }
    expose :province, using: API::V1::Hitung::Provinces::Entities::Province
    expose :regency_code, documentation: { type: Integer, required: true }
    expose :regency, using: API::V1::Hitung::Regencies::Entities::Regency
    expose :district_code, documentation: { type: Integer, required: true }
    expose :district, using: API::V1::Hitung::Districts::Entities::District
    expose :village_code, documentation: { type: Integer, required: true }
    expose :village, using: API::V1::Hitung::Villages::Entities::Village
    expose :latitude, documentation: { type: Float, required: true }
    expose :longitude, documentation: { type: Float, required: true }
    expose :status
    expose :user, with: API::V1::Users::Entities::UserSimple
    expose :logs
  end
end
