module API::V1::Hitung::Dapils::Resources
  class Dapils < API::V1::ApplicationResource
    resource "dapils" do
      desc "get list dapils" do
        detail "get list dapils"
      end
      params do
        optional :province_code, type: Integer, desc: "Province Code"
        optional :regency_code, type: Integer, desc: "Regency Code"
        requires :tingkat, type: String, values: %w[dpr provinsi kabupaten dpd], desc: "Tingkat Pemilihan"
      end
      get "/" do
        case params.tingkat
        when "dpd"
          dapils = Dapil.dapils_by_region params.tingkat
        when "provinsi", "dpr"
          province = Province.find_by(code: params.province_code)
          error!("Provinsi tidak ditemukan", 422) unless province
          dapils = Dapil.dapils_by_region params.tingkat, province
        when "kabupaten"
          regency = Regency.find_by(code: params.regency_code)
          error!("Kabupaten tidak ditemukan", 422) unless regency
          dapils = Dapil.dapils_by_region params.tingkat, nil, regency
        end
        present :dapils, dapils, with: API::V1::Hitung::Dapils::Entities::Dapil
      end

      desc "show a dapil by region" do
        detail "show a dapil by region"
      end
      params do
        requires :province_code, type: Integer, desc: "Province Code"
        requires :regency_code, type: Integer, desc: "Regency Code"
        requires :district_code, type: Integer, desc: "District Code"
        optional :village_code, type: Integer, desc: "Village Code (Mandatory for DPRD Kabupaten)"
        requires :tingkat, type: String, values: %w[dpr provinsi kabupaten dpd], desc: "Tingkat Pemilihan"
      end
      get "/region" do
        province = Province.find_by(code: params.province_code)
        error!("Provinsi tidak ditemukan", 422) unless province

        regency = Regency.find_by(code: params.regency_code)
        error!("Kabupaten tidak ditemukan", 422) unless regency

        district = District.find_by(code: params.district_code)
        error!("Kecamatan tidak ditemukan", 422) unless district

        village = Village.find_by(code: params.village_code)

        dapil = Dapil.by_wilayah params.tingkat, province, regency, district, village
        present dapil, with: API::V1::Hitung::Dapils::Entities::Dapil
      end
    end
  end
end
