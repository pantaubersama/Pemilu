class CreateVillages < ActiveRecord::Migration[5.2]
  def change
    create_table :villages, id: :serial do |t|
      t.integer :code, limit: 8
      t.integer :district_code
      t.string :name

      t.timestamps
    end
    add_index :villages, :id, unique: true
    add_index :villages, :district_code
  end
end
