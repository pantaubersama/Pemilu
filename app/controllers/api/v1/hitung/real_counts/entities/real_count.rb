module API::V1::Hitung::RealCounts::Entities
  class RealCount < API::V1::ApplicationEntity
    expose :id
    expose :tps, documentation: { type: Integer, values: (1..99).to_a, required: true }
    expose :province_code, documentation: { type: Integer, required: true }
    expose :regency_code, documentation: { type: Integer, required: true }
    expose :district_code, documentation: { type: Integer, required: true }
    expose :village_code, documentation: { type: Integer, required: true }
    expose :latitude, documentation: { type: Float, required: true }
    expose :longitude, documentation: { type: Float, required: true }
    expose :status
  end
end
