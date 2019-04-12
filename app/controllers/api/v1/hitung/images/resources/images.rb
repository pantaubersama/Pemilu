module API::V1::Hitung::Images::Resources
  class Images < API::V1::ApplicationResource
    helpers API::V1::Helpers
    helpers API::V1::SharedParams

    resource "images" do
      desc "Display image" do
        headers AUTHORIZATION_HEADERS
        detail "Display image"
      end
      oauth2
      get "/:id" do
        image = ::Hitung::Image.find params.id
        present :image, image, with: API::V1::Hitung::Images::Entities::Image
      end

      desc "List images" do
        detail "List images"
      end
      params do
        optional :hitung_real_count_id
        optional :image_type, values: ["", "c1_presiden", "c1_dpr_ri", "c1_dpd", "c1_dprd_provinsi", "c1_dprd_kabupaten", "suasana_tps"]
      end
      paginate per_page: Pagy::VARS[:items], max_per_page: Pagy::VARS[:max_per_page]
      get "/" do
        images = ::Hitung::Image.where(hitung_real_count_id: params.hitung_real_count_id) if params.hitung_real_count_id.present?
        images = ::Hitung::Image.all unless params.hitung_real_count_id.present?
        images = images.where(image_type: params.image_type) if params.image_type.present?

        records = paginate(images)
        present :image, records, with: API::V1::Hitung::Images::Entities::Image
        present_metas records
      end

      desc "Upload image" do
        detail "Upload image"
        headers AUTHORIZATION_HEADERS
      end
      params do
        requires :file, type: File
        requires :hitung_real_count_id, type: String
        requires :image_type, type: String, values: ["c1_presiden", "c1_dpr_ri", "c1_dpd", "c1_dprd_provinsi", "c1_dprd_kabupaten", "suasana_tps"]
      end
      oauth2
      post "/" do
        authorize_merayakan!
        check_real_count_ownership! current_user, params.hitung_real_count_id

        parameters = {
          image_type: params.image_type, hitung_real_count_id: params.hitung_real_count_id
        }
        img = ::Hitung::Image.new parameters
        img.file = params.file
        status = img.save!

        present :status, status
        present :image, img, with: API::V1::Hitung::Images::Entities::Image
      end

      desc "Delete image" do
        detail "Delete image"
        headers AUTHORIZATION_HEADERS
      end
      oauth2
      delete "/:id" do
        authorize_merayakan!
        img = ::Hitung::Image.find params.id

        check_real_count_ownership! current_user, img.hitung_real_count_id

        img.remove_file
        status = img.destroy!

        present :status, img.destroyed?
        present :image, img, with: API::V1::Hitung::Images::Entities::Image
      end

    end
  end
end
