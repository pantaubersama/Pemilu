class CreatePoliticalParties < ActiveRecord::Migration[5.2]
  def change
    create_table :political_parties, id: :serial do |t|
      t.integer :serial_number
      t.string :name
      t.string :description
      t.string :acronym
      t.string :logo

      t.timestamps
    end
  end
end
