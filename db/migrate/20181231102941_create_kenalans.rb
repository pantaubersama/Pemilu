class CreateKenalans < ActiveRecord::Migration[5.2]
  def change
    create_table :kenalans, id: :uuid do |t|
      t.text :text, null: false

      t.timestamps
    end
  end
end
