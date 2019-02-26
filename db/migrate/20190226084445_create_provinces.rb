class CreateProvinces < ActiveRecord::Migration[5.2]
  def change
    create_table :provinces, id: :serial do |t|
      t.integer :code, null: false, primary: true
      t.string :name
      t.integer :level
      t.string :domain_name

      t.timestamps
    end
  end
end
