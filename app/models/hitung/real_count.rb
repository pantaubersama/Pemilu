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

  # TODO : Optimize this query!
  def logs
    nil
    # {
    #   calculation: {
    #     presiden: calculations.where(calculation_type: "presiden").present? ? true : false,
    #     dpr_ri: calculations.where(calculation_type: "dpr").present? ? true : false,
    #     dpd: calculations.where(calculation_type: "dpd").present? ? true : false,
    #     dprd_provinsi: calculations.where(calculation_type: "provinsi").present? ? true : false,
    #     dprd_kabupaten: calculations.where(calculation_type: "kabupaten").present? ? true : false,
    #   },
    #   form_c1: {
    #     presiden: forms.where(form_c1_type: "presiden").present? ? true : false,
    #     dpr_ri: forms.where(form_c1_type: "dpr").present? ? true : false,
    #     dpd: forms.where(form_c1_type: "dpd").present? ? true : false,
    #     dprd_provinsi: forms.where(form_c1_type: "provinsi").present? ? true : false,
    #     dprd_kabupaten: forms.where(form_c1_type: "kabupaten").present? ? true : false,
    #   },
    #   images: {
    #     presiden: images.where(image_type: "c1_presiden").present? ? true : false,
    #     dpr_ri: images.where(image_type: "c1_dpr_ri").present? ? true : false,
    #     dpd: images.where(image_type: "c1_dpd").present? ? true : false,
    #     dprd_provinsi: images.where(image_type: "c1_dprd_provinsi").present? ? true : false,
    #     dprd_kabupaten: images.where(image_type: "c1_dprb_kabupaten").present? ? true : false,
    #     suasana_tps: images.where(image_type: "suasana_tps").present? ? true : false,
    #   }
    # }
  end

end
