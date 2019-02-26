module Parser
  class DapilDprRi
    attr_accessor :path

    # /data_dapil_dpr_ri.csv
    def initialize p
      @path = [ENV["SCRAPER_PATH"], p].join
    end

    def parse
      file = File.read @path
      csv = CSV.parse(file, headers: true)
      csv.each do |row|
        save_record row
      end
    end

    def save_record row
      data = {
        id: row[0].to_i,
        nama: row[1],
        tingkat: row[2].to_i,
        jumlahPenduduk: (row[3].to_i == -1 ? nil : row[3].to_i),
        idWilayah: row[4].to_i,
        totalAlokasiKursi: row[8].to_i,
        idVersi: row[9].to_i,
        noDapil: row[10].to_i,
        statusCoterminous: true?(row[11])
      }

      Dapil.create! data
    end

    def true? t
      t == "True" ? true : false
    end

  end
end
