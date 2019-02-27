class District < ApplicationRecord
  self.primary_key = 'code'
  belongs_to :regency, foreign_key: :regency_code
  has_many :villages, foreign_key: :district_code
end
