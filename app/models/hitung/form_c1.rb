class Hitung::FormC1 < ApplicationRecord
  enum form_c1_type: [:dpr, :provinsi, :kabupaten, :dpd, :presiden]

  belongs_to :real_count, foreign_key: :hitung_real_count_id

  # agregat

  def a3_total
    a3_laki_laki + a3_perempuan
  end

  def a4_total
    a4_laki_laki + a4_perempuan
  end

  def a_dpk_total
    a_dpk_laki_laki + a_dpk_perempuan
  end

  def pemilih_laki_laki_total
    a3_laki_laki + a4_laki_laki + a_dpk_laki_laki
  end

  def pemilih_perempuan_total
    a3_perempuan + a4_perempuan + a_dpk_perempuan
  end

  def pemilih_total
    pemilih_laki_laki_total + pemilih_perempuan_total
  end

  def c7_dpt_total
    c7_dpt_laki_laki + c7_dpt_perempuan
  end

  def c7_dptb_total
    c7_dptb_laki_laki + c7_dptb_perempuan
  end

  def c7_dpk_total
    c7_dpk_laki_laki + c7_dpk_perempuan
  end

  def c7_laki_laki_hak_pilih_total
    c7_dpt_laki_laki + c7_dptb_laki_laki + c7_dpk_laki_laki
  end

  def c7_perempuan_hak_pilih_total
    c7_dpt_perempuan + c7_dptb_perempuan + c7_dpk_perempuan
  end

  def c7_hak_pilih_total
    c7_laki_laki_hak_pilih_total + c7_perempuan_hak_pilih_total
  end

  def disabilitas_terdaftar_total
    disabilitas_terdaftar_laki_laki + disabilitas_terdaftar_perempuan
  end

  def disabilitas_hak_pilih_total
    disabilitas_hak_pilih_laki_laki + disabilitas_hak_pilih_perempuan
  end

  def total_suara
    surat_dikembalikan + surat_tidak_digunakan + surat_digunakan
  end

end
