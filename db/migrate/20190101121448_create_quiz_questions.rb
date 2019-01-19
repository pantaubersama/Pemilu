class CreateQuizQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :quiz_questions, id: :uuid do |t|
      t.text :content
      t.uuid :quiz_id

      t.timestamps
    end
  end
end
