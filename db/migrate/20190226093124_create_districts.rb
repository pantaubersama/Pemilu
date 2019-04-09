class CreateDistricts < ActiveRecord::Migration[5.2]
  def change
    create_table :districts, id: :serial do |t|
      t.integer :code
      t.integer :regency_code
      t.string :name

      t.timestamps
    end
    add_index :districts, :id, unique: true
    add_index :districts, :regency_code
  end
end
