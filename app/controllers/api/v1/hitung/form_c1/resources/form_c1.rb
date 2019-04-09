module API::V1::Hitung::FormC1::Resources
  class FormC1 < API::V1::ApplicationResource
    helpers API::V1::Helpers
    helpers API::V1::SharedParams

    resource "form_c1" do

      desc "Display saved form C1" do
        detail "Display saved form C1"
      end
      params do
        requires :hitung_real_count_id
        requires :form_c1_type, values: ["dpr", "provinsi", "kabupaten", "dpd", "presiden"]
      end
      get "/" do
        c1 = ::Hitung::FormC1.find_by hitung_real_count_id: params.hitung_real_count_id, form_c1_type: params.form_c1_type

        error! "Data form C1 tidak ditemukan", 404 if c1.nil?

        present :form_c1, c1, with: API::V1::Hitung::FormC1::Entities::FormC1
      end

      desc "Create / update Form C1" do
        detail "Create / update Form C1"
        headers AUTHORIZATION_HEADERS
        params API::V1::Hitung::FormC1::Entities::FormC1.documentation
      end
      oauth2
      put "/" do
        authorize_merayakan!
        check_real_count_ownership! current_user, params.hitung_real_count_id

        total = params.surat_dikembalikan.to_i + params.surat_tidak_digunakan.to_i + params.surat_digunakan.to_i
        error! "Total suara (#{total}) melebihi 500", 422 if total > 500

        c1 = ::Hitung::FormC1.find_or_initialize_by hitung_real_count_id: params.hitung_real_count_id, form_c1_type: params.form_c1_type

        status = c1.update_attributes(c1_params)

        present :status, status
        present :form_c1, c1, with: API::V1::Hitung::FormC1::Entities::FormC1
      end

    end

    # permitted params
    helpers do
      def c1_params
        permitted_params(params.except(:access_token))
          .permit(
                    :hitung_real_count_id,
                    :form_c1_type,
                    :a3_laki_laki,
                    :a3_perempuan,
                    :a4_laki_laki,
                    :a4_perempuan,
                    :a_dpk_laki_laki,
                    :a_dpk_perempuan,
                    :c7_dpt_laki_laki,
                    :c7_dpt_perempuan,
                    :c7_dptb_laki_laki,
                    :c7_dptb_perempuan,
                    :c7_dpk_laki_laki,
                    :c7_dpk_perempuan,
                    :disabilitas_terdaftar_laki_laki,
                    :disabilitas_terdaftar_perempuan,
                    :disabilitas_hak_pilih_laki_laki,
                    :disabilitas_hak_pilih_perempuan,
                    :surat_dikembalikan,
                    :surat_tidak_digunakan,
                    :surat_digunakan,
                  )
      end
    end

  end
end
