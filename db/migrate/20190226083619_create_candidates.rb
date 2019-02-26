class CreateCandidates < ActiveRecord::Migration[5.2]
  def change
    create_table :candidates, id: :serial do |t|
      t.string :name
      t.string :gender
      t.integer :political_party_id
      t.integer :electoral_district_id
      t.integer :serial_number
      t.string :original_filename

      t.timestamps
    end
  end
end
