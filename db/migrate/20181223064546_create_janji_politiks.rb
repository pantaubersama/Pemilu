class CreateJanjiPolitiks < ActiveRecord::Migration[5.2]
  def change
    create_table :janji_politiks, id: :uuid do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.string :image
      t.uuid :user_id

      t.timestamps
    end
  end
end
