class ChangeKecamatanKrannga < ActiveRecord::Migration[5.2]
  def up
    # https://id.wikipedia.org/wiki/Daftar_kecamatan_dan_kelurahan_di_Kota_Mojokerto

    v = Village.find_by code: 3576011001
    v.update_attributes!(id: 3576031002, code: 3576031002, district_code: 357603)

    v = Village.find_by code: 3576011002
    v.update_attributes!(id: 3576031003, code: 3576031003, district_code: 357603)

    v = Village.find_by code: 3576021002
    v.update_attributes!(id: 3576031001, code: 3576031001, district_code: 357603)

    v = Village.find_by code: 3576021005
    v.update_attributes!(id: 3576031007, code: 3576031007, district_code: 357603)

    v = Village.find_by code: 3576021006
    v.update_attributes!(id: 3576031006, code: 3576031006, district_code: 357603)

    v = Village.find_by code: 3576021007
    v.update_attributes!(id: 3576031005, code: 3576031005, district_code: 357603)
  end

  def down
    v = Village.find_by code: 3576031002
    v.update_attributes!(id: 3576011001, code: 3576011001, district_code: 357601)

    v = Village.find_by code: 3576031003
    v.update_attributes!(id: 3576011002, code: 3576011002, district_code: 357601)

    v = Village.find_by code: 3576031001
    v.update_attributes!(id: 3576021002, code: 3576021002, district_code: 357602)

    v = Village.find_by code: 3576031007
    v.update_attributes!(id: 3576021005, code: 3576021005, district_code: 357602)

    v = Village.find_by code: 3576031006
    v.update_attributes!(id: 3576021006, code: 3576021006, district_code: 357602)

    v = Village.find_by code: 3576031005
    v.update_attributes!(id: 3576021007, code: 3576021007, district_code: 357602)
  end
end
