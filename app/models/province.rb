class Province < ApplicationRecord
  has_many :regencies, foreign_key: :province_id
end
