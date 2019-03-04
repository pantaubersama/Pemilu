module API::V1::Hitung::Candidates::Entities
  class Candidate < Grape::Entity
    expose :id
    expose :name
    expose :gender
    expose :political_party_id
    expose :electoral_district_id
    expose :serial_number
    expose :original_filename
  end
end
