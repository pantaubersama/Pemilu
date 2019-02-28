module API::V1::Hitung::RealCounts::Resources
  class RealCounts < API::V1::ApplicationResource
    helpers API::V1::Helpers
    helpers API::V1::SharedParams

    resource "real_counts" do
      desc "Create draft real count" do
        detail "Create draft real count"
        params API::V1::Hitung::RealCounts::Entities::RealCount.documentation
        headers AUTHORIZATION_HEADERS
      end
      oauth2
      post "/" do
        hitung = ::Hitung::RealCount.new hitung_params
        hitung.user_id = current_user.id
        hitung.status = "draft"

        p = Province.find_by code: params.province_code
        error! "Provinsi tidak ditemukan", 404 unless p

        r = Regency.find_by code: params.regency_code, province_id: params.province_code
        error! "Kabupaten tidak ditemukan", 404 unless r

        d = District.find_by code: params.district_code, regency_code: params.regency_code
        error! "Kecamatan tidak ditemukan", 404 unless d

        v = Village.find_by code: params.village_code, district_code: params.district_code
        error! "Kelurahan tidak ditemukan", 404 unless v

        status = hitung.save!

        present :status, status
        present :real_count, hitung, with: API::V1::Hitung::RealCounts::Entities::RealCount
      end

      desc "Publish real count" do
        detail "Publish real count"
        headers AUTHORIZATION_HEADERS
      end
      oauth2
      post "/:id/publish" do
        hitung = ::Hitung::RealCount.find params.id
        status = hitung.published!

        present :status, status
        present :real_count, hitung, with: API::V1::Hitung::RealCounts::Entities::RealCount
      end

      desc "Draft real count" do
        detail "Draft real count"
        headers AUTHORIZATION_HEADERS
      end
      oauth2
      post "/:id/draft" do
        hitung = ::Hitung::RealCount.find params.id
        status = hitung.draft!

        present :status, status
        present :real_count, hitung, with: API::V1::Hitung::RealCounts::Entities::RealCount
      end
    end

    # permitted params
    helpers do
      def hitung_params
        permitted_params(params.except(:access_token)).permit(:tps, :province_code, :regency_code, :district_code, :village_code, :latitude, :longitude)
      end
    end

  end
end
