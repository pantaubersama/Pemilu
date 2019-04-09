class CreateDapils < ActiveRecord::Migration[5.2]
  def change
    create_table :dapils, id: :integer do |t|
      t.string :nama
      t.integer :tingkat
      t.string :jumlahPenduduk
      t.integer :idWilayah
      t.integer :totalAlokasiKursi
      t.integer :idVersi
      t.integer :noDapil
      t.boolean :statusCoterminous
      t.integer :idPro
      t.integer :parent
      t.integer :alokasiKursi
      t.integer :sisaPenduduk
      t.integer :peringkatPenduduk
      t.integer :alokasiSisaKursi
      t.decimal :stdDev
      t.decimal :mean
      t.integer :dapilOwner

      t.timestamps
    end

    add_index :dapils, :id, unique: true
    add_index :dapils, :idWilayah
    add_index :dapils, :idVersi
    add_index :dapils, :idPro
    add_index :dapils, :parent
  end
end
