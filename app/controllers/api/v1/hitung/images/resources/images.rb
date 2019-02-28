module API::V1::Hitung::Images::Resources
  class Images < API::V1::ApplicationResource
    helpers API::V1::Helpers
    helpers API::V1::SharedParams

    resource "images" do

      desc "Upload image" do
        detail "Upload image"
        headers AUTHORIZATION_HEADERS
      end
      params do
        requires :file, type: File
        requires :hitung_real_count_id, type: String
        requires :image_type, type: String, values: ["c1_presiden", "c1_dpr_ri", "c1_dpd", "c1_dprd_provinsi", "c1_dprb_kabupaten", "suasana_tps"]
      end
      oauth2
      post "/" do
        owned_real_counts = ::Hitung::RealCount.where(user_id: current_user.id).map(&:id)
        error! "Anda bukan pemilik perhitungan ini", 404 unless owned_real_counts.include? params.hitung_real_count_id

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
        img = ::Hitung::Image.find params.id

        owned_real_counts = ::Hitung::RealCount.where(user_id: current_user.id).map(&:id)
        error! "Anda bukan pemilik gambar ini", 404 unless owned_real_counts.include? img.hitung_real_count_id

        img.remove_file
        status = img.destroy!

        present :status, img.destroyed?
        present :image, img, with: API::V1::Hitung::Images::Entities::Image
      end

    end
  end
end
