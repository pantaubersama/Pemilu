class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions, id: :uuid do |t|
      t.string :body, limit: 260
      t.datetime :deleted_at, index: true
      t.uuid :user_id, index: true, null: false

      t.timestamps
    end
  end
end
