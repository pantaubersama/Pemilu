module API::V1::Hitung::Summary::Resources
  class PresidentList < API::V1::ApplicationResource
    resource "summary" do

      desc "list perhitungan presiden" do
        detail "list perhitungan presiden satu tingkat dibawah level <br>
                level : <br>
                0 => Nasional <br>
                1 => Provinsi <br>
                2 => Kabupaten / Kota <br>
                3 => Kecamatan <br>
                4 => Desa `hitung/v1/real_counts` <br>
               "
      end
      params do
        requires :level, type: Integer, values: (0..3).to_a, desc: "Level"
        optional :region, type: Integer, desc: "Kode Wilayah"
      end
      get "president/list" do
        percentages = []

        case params.level
        when 0
          Province.all.each do |province|
            data = {}
            data[:percentage] = ::Hitung::PresidentSummary.new.run "province", province.code
            data[:region] = province
            percentages << data
          end
          present :region, nil
        when 1
          province = Province.find params.region
          regencies = Regency.where(province_id: params.region)
          regencies.each do |province|
            data = {}
            data[:percentage] = ::Hitung::PresidentSummary.new.run "regency", province.code
            data[:region] = province
            percentages << data
          end
          present :region, province, using: API::V1::Hitung::Provinces::Entities::Province
        when 2
          regency = Regency.find params.region
          districts = District.where(regency_code: params.region)
          districts.each do |province|
            data = {}
            data[:percentage] = ::Hitung::PresidentSummary.new.run "district", province.code
            data[:region] = province
            percentages << data
          end
          present :region, regency, using: API::V1::Hitung::Regencies::Entities::Regency
        when 3
          district = District.find params.region
          villages = Village.where(district_code: params.region)
          villages.each do |province|
            data = {}
            data[:percentage] = ::Hitung::PresidentSummary.new.run "village", province.code
            data[:region] = province
            percentages << data
          end
          present :region, district, using: API::V1::Hitung::Villages::Entities::Village
        end

        sorted_percentages =  percentages.sort_by{|h| h[:percentage].present? ? h[:percentage][:total_vote] : 0 }.reverse!

        present :percentages, sorted_percentages, using: API::V1::Hitung::Summary::Entities::President
      end

    end
  end
end
