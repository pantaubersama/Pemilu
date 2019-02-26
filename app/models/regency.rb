class Regency < ApplicationRecord
  self.primary_key = 'code'
  belongs_to :province
  has_many :districts, foreign_key: :regency_code
end
