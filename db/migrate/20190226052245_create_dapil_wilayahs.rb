class CreateDapilWilayahs < ActiveRecord::Migration[5.2]
  def change
    create_table :dapil_wilayahs, id: :integer do |t|
      t.integer :idDapil
      t.integer :idWilayah
      t.string :namaWilayah
      t.integer :urutanWilayahDapil
      t.boolean :flagInclude

      t.timestamps
    end

    add_index :dapil_wilayahs, :id, unique: true
    add_index :dapil_wilayahs, :idDapil
    add_index :dapil_wilayahs, :idWilayah
  end
end
