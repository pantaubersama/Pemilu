class Hitung::CalculationDetail < ApplicationRecord
  belongs_to :real_count, foreign_key: :hitung_real_count_id
  belongs_to :calculation, foreign_key: :hitung_calculation_id
end
