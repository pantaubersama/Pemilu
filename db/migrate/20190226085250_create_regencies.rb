class CreateRegencies < ActiveRecord::Migration[5.2]
  def change
    create_table :regencies, id: :serial do |t|
      t.integer :province_id, null: false
      t.integer :code, null: false, primary: true
      t.string :name
      t.integer :level
      t.string :domain_name

      t.timestamps
    end
    add_index :regencies, :province_id
  end
end
