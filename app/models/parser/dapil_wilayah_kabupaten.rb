# This module only for adding id_wilayah to Village
module Parser
  class DapilWilayahKabupaten
    attr_accessor :path

    # /data_wilayah_dpr
    def initialize p
      @path = [ENV["SCRAPER_PATH"], p, "/*.json"].join
    end

    def parse
      Dir.glob(@path) do |json_file|
        puts "working on #{json_file} .."
        parse_single_file json_file
      end
    end

    def parse_single_file file
      id_parent = file.split("_").last.split(".").first.to_i
      json_response = JSON.parse(File.read(file))

      json_response.each do |response|
        data =  {
                  idWilayah: response["idWilayah"],
                  stdDev: response["stdDev"],
                  mean: response["mean"],
                  maxAlokasiKursi: response["maxAlokasiKursi"],
                  minAlokasiKursi: response["minAlokasiKursi"]
                }
        # update_dapil data
        update_wilayah response["dapil"], id_parent
      end

    end

    def update_dapil data
      # d = Dapil.find_by idWilayah: data[:idWilayah]
      # d.update_attributes!({
      #   stdDev: data[:stdDev],
      #   mean: data[:mean],
      #   maxAlokasiKursi: data[:maxAlokasiKursi],
      #   minAlokasiKursi: data[:minAlokasiKursi]
      # })
    end

    def update_wilayah data, id_parent
      data.each do |datum|
        update_dapil_wilayah datum["wilayah"], id_parent
      end
    end

    def update_dapil_wilayah data, id_parent
      data.each do |datum|
        d = {
              id: datum["id"],
              idDapil: datum["idDapil"],
              idWilayah: datum["idWilayah"],
              namaWilayah: datum["namaWilayah"],
              urutanWilayahDapil: datum["urutanWilayahDapil"],
              flagInclude: datum["flagInclude"]
            }
        if datum["subGroup"].present?
          village_name = datum["namaWilayah"].downcase.remove("kel. ")
          district_codes = Regency.where(id_wilayah: id_parent).map{|x| x.districts.map(&:code)}.last
          village = Village.where(district_code: district_codes)
            .where("lower(name) like ?", '%' + village_name + '%').first
          village.update_attributes!(id_wilayah: datum["idWilayah"]) if village.present?
        end
        puts d
        # DapilWilayah.create! d
      end
    end

  end
end
