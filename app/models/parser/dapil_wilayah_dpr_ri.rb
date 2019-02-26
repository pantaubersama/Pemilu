module Parser
  class DapilWilayahDprRi
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
      json_response = JSON.parse(File.read(file))

      json_response.each do |response|
        data =  {
                  idWilayah: response["idWilayah"],
                  stdDev: response["stdDev"],
                  mean: response["mean"],
                  maxAlokasiKursi: response["maxAlokasiKursi"],
                  minAlokasiKursi: response["minAlokasiKursi"]
                }
        update_dapil data
        update_wilayah response["dapil"]
      end

    end

    def update_dapil data
      d = Dapil.find_by idWilayah: data[:idWilayah]
      d.update_attributes!({
        stdDev: data[:stdDev],
        mean: data[:mean],
        maxAlokasiKursi: data[:maxAlokasiKursi],
        minAlokasiKursi: data[:minAlokasiKursi]
      })
    end

    def update_wilayah data
      data.each do |datum|
        update_dapil_wilayah datum["wilayah"]
      end
    end

    def update_dapil_wilayah data
      data.each do |datum|
        d = {
              id: datum["id"],
              idDapil: datum["idDapil"],
              idWilayah: datum["idWilayah"],
              namaWilayah: datum["namaWilayah"],
              urutanWilayahDapil: datum["urutanWilayahDapil"],
              flagInclude: datum["flagInclude"]
            }

        puts d
        DapilWilayah.create! d
      end
    end

  end
end
