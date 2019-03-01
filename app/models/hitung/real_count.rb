class Hitung::RealCount < ApplicationRecord
  enum status: [:draft, :published]

  has_many :images, class_name: "Hitung::Image", foreign_key: :hitung_real_count_id
  has_one :form_c1, class_name: "Hitung::FormC1", foreign_key: :hitung_real_count_id
end
