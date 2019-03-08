class Hitung::RealCount < ApplicationRecord
  enum status: [:draft, :published]

  has_many :images, class_name: "Hitung::Image", foreign_key: :hitung_real_count_id
  has_many :forms, class_name: "Hitung::FormC1", foreign_key: :hitung_real_count_id
  has_many :calculations, class_name: "Hitung::Calculation", foreign_key: :hitung_real_count_id

  belongs_to :province, foreign_key: :province_code, optional: true
  belongs_to :regency, foreign_key: :regency_code, optional: true
  belongs_to :district, foreign_key: :district_code, optional: true
  belongs_to :village, foreign_key: :village_code, optional: true

  validates_presence_of :province_code, :regency_code, :district_code, :village_code

  def user
    User.find self.user_id
  end
end
