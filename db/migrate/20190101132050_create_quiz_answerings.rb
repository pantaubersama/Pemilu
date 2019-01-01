class CreateQuizAnswerings < ActiveRecord::Migration[5.2]
  def change
    create_table :quiz_answerings, id: :uuid do |t|
      t.uuid :quiz_participation_id
      t.uuid :quiz_id
      t.uuid :quiz_question_id
      t.uuid :quiz_answer_id
      t.uuid :user_id

      t.timestamps
    end

    add_index :quiz_answerings, [:quiz_participation_id, :quiz_question_id], unique: true, name: "participating_in_question"
  end
end
