class Hitung::RealCount < ApplicationRecord
  enum status: [:draft, :published]
end
