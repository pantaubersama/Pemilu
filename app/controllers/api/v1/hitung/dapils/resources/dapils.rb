module API::V1::Hitung::Dapils::Resources
  class Dapils < API::V1::ApplicationResource
    resource "dapils" do
      desc "get dapil by region" do
        detail "get dapil by region"
      end
      params do
        requires :province_code, type: Integer, desc: "Province Code"
        requires :regency_code, type: Integer, desc: "Regency Code"
        requires :district_code, type: Integer, desc: "District Code"
        requires :tingkat, type: String, values: %w[dpr provinsi kabupaten dpd], desc: "Tingkat Pemilihan"
      end
      get "/" do
        province = Province.find_by(code: params.province_code)
        error!("Record Province tidak ditemukan", 422) unless province

        regency = Regency.find_by(code: params.regency_code)
        error!("Record Regency tidak ditemukan", 422) unless regency

        district = District.find_by(code: params.district_code)
        error!("Record District tidak ditemukan", 422) unless district

        dapil = Dapil.by_wilayah params.tingkat, province, regency, district
        present dapil, with: API::V1::Hitung::Dapils::Entities::Dapil
      end
    end
  end
end
