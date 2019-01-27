class CreateQuizPreferences < ActiveRecord::Migration[5.2]
  def change
    create_table :quiz_preferences, id: :uuid do |t|
      t.uuid :user_id
      t.string :image_result

      t.timestamps
    end
  end
end
