module Parser
  class LocalCsv

    def self.insert_regencies
      file = File.read("#{ENV['SCRAPER_PATH']}/data_kabupaten.csv")
      csv = CSV.parse(file, headers: true)
      csv.each do |row|
        data = {
          id: row['kodeKab'].to_i,
          province_id: row['kodePro'].to_i,
          code: row['kodeKab'].to_i,
          name: row['namaWilayah'],
          level: row['tingkatWilayah'].to_i,
          domain_name: row['domainName'],
          id_wilayah: row['idWilayah'].to_i,
          id_parent: row['idParent'].to_i
        }
        Regency.create! data
      end
    end

    def self.insert_district
      file = File.read("#{ENV['SCRAPER_PATH_2']}/daftar_kecamatan_pileg2019.csv")
      csv = CSV.parse(file, headers: true)
      csv.each do |row|
        data = {
          id: row['kodeKec'].to_i,
          code: row['kodeKec'].to_i,
          regency_code: row['kodeKab'].to_i,
          name: row['namaKec'],
          id_parent: row['idParent'].to_i,
          id_wilayah: row['idWilayah'].to_i,
          level: row['tingkatWilayah'].to_i
        }
        District.create! data
      end
    end

    def self.insert_village
      file = File.open(Rails.root.join('lib', 'data', 'villages_version_2.csv'))
      csv = CSV.parse(file, headers: true)
      csv.each do |row|
        data = {
          id: row['code'].to_i,
          code: row['code'].to_i,
          district_code: row['district_code'].to_i,
          name: row['name']
        }
        Village.create! data
      end
    end

  end
end
