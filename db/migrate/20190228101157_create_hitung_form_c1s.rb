class CreateHitungFormC1s < ActiveRecord::Migration[5.2]
  def change
    create_table :hitung_form_c1s, id: :uuid do |t|
      t.integer :a3_laki_laki, default: 0
      t.integer :a3_perempuan, default: 0
      t.integer :a4_laki_laki, default: 0
      t.integer :a4_perempuan, default: 0
      t.integer :a_dpk_laki_laki, default: 0
      t.integer :a_dpk_perempuan, default: 0
      t.integer :c7_dpt_laki_laki, default: 0
      t.integer :c7_dpt_perempuan, default: 0
      t.integer :c7_dptb_laki_laki, default: 0
      t.integer :c7_dptb_perempuan, default: 0
      t.integer :c7_dpk_laki_laki, default: 0
      t.integer :c7_dpk_perempuan, default: 0
      t.integer :disabilitas_terdaftar_laki_laki, default: 0
      t.integer :disabilitas_terdaftar_perempuan, default: 0
      t.integer :disabilitas_hak_pilih_laki_laki, default: 0
      t.integer :disabilitas_hak_pilih_perempuan, default: 0
      t.integer :surat_dikembalikan, default: 0
      t.integer :surat_tidak_digunakan, default: 0
      t.integer :surat_digunakan, default: 0
      t.uuid    :hitung_real_count_id
      t.integer :form_c1_type

      t.timestamps
    end

    add_index :hitung_form_c1s, :hitung_real_count_id
  end
end
