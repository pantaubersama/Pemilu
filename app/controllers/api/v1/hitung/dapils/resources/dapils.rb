module API::V1::Hitung::Dapils::Resources
  class Dapils < API::V1::ApplicationResource

    resource "regions" do
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
          case params.tingkat
          when "dpd"
            province = Province.find_by(code: params.province_code)
            error!("Record Province tidak ditemukan", 422) unless province

            dapil = Dapil.where(tingkat: 3, idWilayah: province.id_wilayah).first
          when "dpr"
            regency = Regency.find_by(code: params.regency_code)
            error!("Record Regency tidak ditemukan", 422) unless regency

            dapil = DapilWilayah.joins(:dapil)
              .where(idWilayah: regency.id_wilayah)
              .where("dapils.tingkat = ?", 0).last.dapil
          when "provinsi"
            regency = Regency.find_by(code: params.regency_code)
            error!("Record Regency tidak ditemukan", 422) unless regency

            dapil = DapilWilayah.joins(:dapil)
              .where(idWilayah: regency.id_wilayah)
              .where("dapils.tingkat = ?", 1).last.dapil
          when "kabupaten"
            district = District.find_by(code: params.district_code)
            error!("Record District tidak ditemukan", 422) unless district

            dapil = DapilWilayah.joins(:dapil)
              .where(idWilayah: district.id_wilayah)
              .where("dapils.tingkat = ?", 2).last.dapil
          end
          present dapil, with: API::V1::Hitung::Dapils::Entities::Dapil
        end
      end
    end
  end
end
