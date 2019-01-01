class CreateQuizAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :quiz_answers, id: :uuid do |t|
      t.integer :team
      t.text :content
      t.uuid :quiz_question_id, index: true

      t.timestamps
    end
  end
end
