module Parser
  class DapilDpd
    attr_accessor :path
    # dapil.csv
    def initialize p
      @path = [ENV["SCRAPER_DPD_PATH"], p].join
    end

    def parse
      file = File.read @path
      csv = CSV.parse(file, headers: false)
      csv.each do |row|
        save_record row
      end
    end

    def save_record row
      data = {
        id: row[0].to_i,
        nama: row[1],
        tingkat: 3,
      }

      Dapil.create! data
    end
  end
end
