module API::V1::Hitung::RealCounts::Resources
  class RealCounts < API::V1::ApplicationResource
    helpers API::V1::Helpers
    helpers API::V1::SharedParams

    resource "real_counts" do
      desc "List real count / TPS" do
        detail "List real count / TPS"
        headers OPTIONAL_AUTHORIZATION_HEADERS
      end
      paginate per_page: Pagy::VARS[:items], max_per_page: Pagy::VARS[:max_per_page]
      params do
        optional :user_id, type: String
        optional :village_code, type: String
        optional :dapil_id, type: String
      end
      optional_oauth2
      get "/" do
        record = ::Hitung::RealCount.includes(:province, :regency, :district, :village)
        if params.user_id.present? && current_user.present? && params.user_id == current_user.id
          record = record.all
        else
          record = record.published
        end
        record = record.where(user_id: params.user_id) if params.user_id.present?
        record = record.joins(:calculations).where(village_code: params.village_code).where("hitung_calculations.calculation_type = ?", 4) if params.village_code.present?
        record = record.joins(:calculations).where("hitung_calculations.dapil_id = ?", params.dapil_id) if params.dapil_id.present?
        record = record.order("hitung_real_counts.created_at desc")
        hitungs = paginate(record)

        present :real_counts, hitungs, with: API::V1::Hitung::RealCounts::Entities::RealCount
        present_metas hitungs
      end

      desc "Create real count" do
        detail "Create real count"
        params API::V1::Hitung::RealCounts::Entities::RealCount.documentation
        headers AUTHORIZATION_HEADERS
      end
      oauth2
      post "/" do
        authorize_merayakan!

        hitung = ::Hitung::RealCount.new hitung_params
        hitung.user_id = current_user.id
        hitung.status = "draft"

        p = Province.find_by code: params.province_code
        error! "Provinsi tidak ditemukan", 404 unless p

        r = Regency.find_by code: params.regency_code, province_id: params.province_code
        error! "Kabupaten tidak ditemukan", 404 unless r

        d = District.find_by code: params.district_code, regency_code: params.regency_code
        error! "Kecamatan tidak ditemukan", 404 unless d

        v = Village.find_by code: params.village_code, district_code: params.district_code if params.village_code.present?
        # error! "Kelurahan tidak ditemukan", 404 unless v

        status = hitung.save!

        present :status, status
        present :real_count, hitung, with: API::V1::Hitung::RealCounts::Entities::RealCount
      end

      desc "Show real count" do
        detail "Show real count"
      end
      get "/:id" do
        hitung = ::Hitung::RealCount.find params.id
        present :real_count, hitung, with: API::V1::Hitung::RealCounts::Entities::RealCount
      end

      desc "Update real count" do
        detail "Update real count"
        headers AUTHORIZATION_HEADERS
      end
      params do
        requires :tps, type: Integer, values: (1..99).to_a
      end
      oauth2
      put "/:id" do
        authorize_merayakan!

        hitung = ::Hitung::RealCount.find_by id: params.id, user_id: current_user.id
        status = hitung.update_attributes!({tps: params.tps})

        present :status, status
        present :real_count, hitung, with: API::V1::Hitung::RealCounts::Entities::RealCount
      end

      desc "Destroy real count" do
        detail "Destroy real count"
        headers AUTHORIZATION_HEADERS
      end
      oauth2
      delete "/:id" do
        authorize_merayakan!

        hitung = ::Hitung::RealCount.find_by id: params.id, user_id: current_user.id

        hitung.destroy!
        status = hitung.destroyed?

        present :status, status
        present :real_count, hitung, with: API::V1::Hitung::RealCounts::Entities::RealCount
      end

      desc "Publish real count" do
        detail "Publish real count"
        headers AUTHORIZATION_HEADERS
      end
      oauth2
      post "/:id/publish" do
        authorize_merayakan!

        hitung = ::Hitung::RealCount.find_by id: params.id, user_id: current_user.id
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
        authorize_merayakan!

        hitung = ::Hitung::RealCount.find_by id: params.id, user_id: current_user.id
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
