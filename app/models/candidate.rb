class Candidate < ApplicationRecord
  belongs_to :dapil, foreign_key: :electoral_district_id
end
