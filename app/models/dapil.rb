class Dapil < ApplicationRecord
  enum tingkat: [:dpr, :provinsi, :kabupaten, :dpd]

  has_many :dapil_wilayahs, foreign_key: :idWilayah

  def self.by_wilayah level, province, regency, district
    case level
    when "dpd"
      dapil = Dapil.where(tingkat: 3, idWilayah: province.id_wilayah).first
    when "dpr"
      dapil = DapilWilayah.joins(:dapil)
        .where(idWilayah: regency.id_wilayah)
        .where("dapils.tingkat = ?", 0).last.dapil
    when "provinsi"
      dapil = DapilWilayah.joins(:dapil)
        .where(idWilayah: regency.id_wilayah)
        .where("dapils.tingkat = ?", 1).last.dapil
    when "kabupaten"
      dapil = DapilWilayah.joins(:dapil)
        .where(idWilayah: district.id_wilayah)
        .where("dapils.tingkat = ?", 2).last.dapil
    end
    dapil
  end
end
