module Parser
  class CandidateDpd
    attr_accessor :path
    # caleg
    def initialize p
      @path = [ENV["SCRAPER_DPD_PATH"], p, "/*.csv"].join
    end

    def parse
      Dir.glob(@path) do |csv_file|
        puts "working on #{csv_file} .."
        parse_single_file csv_file
      end
    end

    def parse_single_file file
      file_name = File.basename(file, '.csv')
      file = File.read file
      csv = CSV.parse(file, headers: false)
      csv.each do |row|
        save_record(row, file_name)
      end
    end

    def save_record(row, file_name)
      data = {
        id: Candidate.maximum(:id).to_i.next,
        name: row[1],
        serial_number: row[0].to_i,
        electoral_district_id: file_name
      }

      Candidate.create! data
    end

  end
end
