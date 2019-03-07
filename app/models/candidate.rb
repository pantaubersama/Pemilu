class Candidate < ApplicationRecord
  belongs_to :dapil, foreign_key: :electoral_district_id
  belongs_to :political_party, foreign_key: :political_party_id, optional: true
end
