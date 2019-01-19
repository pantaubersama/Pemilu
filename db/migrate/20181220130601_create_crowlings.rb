class CreateCrowlings < ActiveRecord::Migration[5.2]
  def change
    create_table :crowlings, id: :uuid do |t|
      t.string :keywords, null: false
      t.integer :team, null: false

      t.timestamps
    end
  end
end
