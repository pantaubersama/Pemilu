class CreateUserKenalans < ActiveRecord::Migration[5.2]
  def change
    create_table :user_kenalans, id: :uuid do |t|
      t.uuid :user_id, null: false
      t.uuid :kenalan_id, null: false
      t.datetime :action_at

      t.timestamps
    end
    add_index :user_kenalans, [:user_id, :kenalan_id], unique: true
  end
end
