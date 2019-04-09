module API::V1::Hitung::Summary::Resources
  class PresidentDetail < API::V1::ApplicationResource
    resource "summary" do
      desc "perhitungan presiden" do
        detail "perhitungan presiden <br>
                level : <br>
                0 => se-Indonesia <br>
                1 => Provinsi <br>
                2 => Kabupaten / Kota <br>
                3 => Kecamatan <br>
                4 => Desa / Kelurahan <br>
                5 => TPS (Rata - rata) <br>
                6 => Perseorangan (Satu orang satu TPS) <br>
               "
      end
      params do
        requires :level, type: Integer, values: (0..6).to_a, desc: "Level"
        optional :region, type: Integer, desc: "Kode Wilayah"
        optional :tps, type: Integer, desc: "TPS (hanya untuk level 5 dan 6)"
        optional :hitung_real_count_id, type: String, desc: "Real Count ID (hanya untuk level 6)"
      end
      get "president/show" do

        case params.level
        when 0
          present :tps, nil
          present :user, nil
          result = ::Hitung::PresidentSummary.new.run
        when 1
          region = ::Province.find_by code: params.region
          present :tps, nil
          present :user, nil
          result = ::Hitung::PresidentSummary.new.run "province", params.region
        when 2
          region = ::Regency.find_by code: params.region
          present :tps, nil
          present :user, nil
          result = ::Hitung::PresidentSummary.new.run "regency", params.region
        when 3
          region = ::District.find_by code: params.region
          present :tps, nil
          present :user, nil
          result = ::Hitung::PresidentSummary.new.run "district", params.region
        when 4
          region = ::Village.find_by code: params.region
          present :tps, nil
          present :user, nil
          result = ::Hitung::PresidentSummary.new.run "village", params.region
        when 5
          region = ::Village.find_by code: params.region
          error! "TPS membutuhkan Kode Wilayah", 406 if region.nil?
          present :tps, params.tps
          present :user, nil
          result = ::Hitung::PresidentSummary.new.run "tps", params.region, params.tps
        when 6
          region = ::Village.find_by code: params.region
          hitung = ::Hitung::RealCount.find params.hitung_real_count_id
          error! "TPS membutuhkan Kode Wilayah", 406 if region.nil?
          error! "Perhitungan tidak ditemukan", 406 if hitung.nil?
          present :tps, params.tps
          present :user, hitung.user, using: API::V1::Users::Entities::User
          result = ::Hitung::PresidentSummary.new.run "perseorangan", params.region, params.tps, params.hitung_real_count_id
        end

        present :percentage, result, using: API::V1::Hitung::Summary::Entities::President

      end

    end
  end
end
