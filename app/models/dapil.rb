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
      query = DapilWilayah.joins(:dapil)
        .where(idWilayah: regency.id_wilayah)
        .where("dapils.tingkat = ?", 1)
      if query.empty?
        query = DapilWilayah.joins(:dapil)
        .where(idWilayah: district.id_wilayah)
        .where("dapils.tingkat = ?", 1)
        dapil = query.last.dapil
      else
        dapil = query.last.dapil
      end
    when "kabupaten"
      dapil = DapilWilayah.joins(:dapil)
        .where(idWilayah: district.id_wilayah)
        .where("dapils.tingkat = ?", 2).last.dapil
    end
    dapil
  end

  def self.dapils_by_region level, province=nil, regency=nil
    case level
    when "dpd"
      dapils = Dapil.where(tingkat: 3).order("nama asc")
    when "dpr"
      dapils = Dapil.where(tingkat: 0, idWilayah: province.id_wilayah).order("id asc")
    when "provinsi"
      dapils = Dapil.where(tingkat: 1, idWilayah: province.id_wilayah).order("id asc")
    when "kabupaten"
      dapils = Dapil.where(tingkat: 2, idWilayah: regency.id_wilayah).order("id asc")
    end
    dapils
  end

end
