module API::V1::Hitung::FormC1::Entities
  class FormC1 < API::V1::ApplicationEntity
    expose :id
    expose :hitung_real_count_id, documentation: { type: String, required: true }
    expose :form_c1_type, documentation: { type: String, required: true, values: ["dpr", "provinsi", "kabupaten", "dpd", "presiden"] }
    expose :a3_laki_laki, documentation: { type: Integer, required: false, default: 0 }
    expose :a3_perempuan, documentation: { type: Integer, required: false, default: 0 }
    expose :a4_laki_laki, documentation: { type: Integer, required: false, default: 0 }
    expose :a4_perempuan, documentation: { type: Integer, required: false, default: 0 }
    expose :a_dpk_laki_laki, documentation: { type: Integer, required: false, default: 0 }
    expose :a_dpk_perempuan, documentation: { type: Integer, required: false, default: 0 }
    expose :c7_dpt_laki_laki, documentation: { type: Integer, required: false, default: 0 }
    expose :c7_dpt_perempuan, documentation: { type: Integer, required: false, default: 0 }
    expose :c7_dptb_laki_laki, documentation: { type: Integer, required: false, default: 0 }
    expose :c7_dptb_perempuan, documentation: { type: Integer, required: false, default: 0 }
    expose :c7_dpk_laki_laki, documentation: { type: Integer, required: false, default: 0 }
    expose :c7_dpk_perempuan, documentation: { type: Integer, required: false, default: 0 }
    expose :disabilitas_terdaftar_laki_laki, documentation: { type: Integer, required: false, default: 0 }
    expose :disabilitas_terdaftar_perempuan, documentation: { type: Integer, required: false, default: 0 }
    expose :disabilitas_hak_pilih_laki_laki, documentation: { type: Integer, required: false, default: 0 }
    expose :disabilitas_hak_pilih_perempuan, documentation: { type: Integer, required: false, default: 0 }
    expose :surat_dikembalikan, documentation: { type: Integer, required: false, default: 0 }
    expose :surat_tidak_digunakan, documentation: { type: Integer, required: false, default: 0 }
    expose :surat_digunakan, documentation: { type: Integer, required: false, default: 0 }

    # agregat
    expose :aggregates do
      expose :a3_total
      expose :a4_total
      expose :a_dpk_total
      expose :pemilih_laki_laki_total
      expose :pemilih_perempuan_total
      expose :pemilih_total

      expose :c7_dpt_total
      expose :c7_dptb_total
      expose :c7_dpk_total
      expose :c7_laki_laki_hak_pilih_total
      expose :c7_perempuan_hak_pilih_total
      expose :c7_hak_pilih_total

      expose :disabilitas_terdaftar_total
      expose :disabilitas_hak_pilih_total

      expose :total_suara
    end
  end
end
