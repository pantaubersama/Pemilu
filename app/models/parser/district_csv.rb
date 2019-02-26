module Parser
  class DistrictCsv

    def self.parse
      file = File.open(Rails.root.join('lib', 'data', 'districts_version_2.csv'))
      csv = CSV.parse(file, headers: true)
      csv.each do |row|
        data = {
          id: row['code'].to_i,
          code: row['code'].to_i,
          regency_code: row['regency_code'].to_i,
          name: row['name']
        }
      District.create! data
      end
    end

  end
end
