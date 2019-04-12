class Hitung::Image < ApplicationRecord
  mount_uploader :file, Hitung::FileUploader

  enum image_type: [:c1_presiden, :c1_dpr_ri, :c1_dpd, :c1_dprd_provinsi, :c1_dprd_kabupaten, :suasana_tps]

  belongs_to :real_count, foreign_key: :hitung_real_count_id

end
