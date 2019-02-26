class District < ApplicationRecord
  self.primary_key = 'code'
  belongs_to :regency, foreign_key: :regency_code
end
