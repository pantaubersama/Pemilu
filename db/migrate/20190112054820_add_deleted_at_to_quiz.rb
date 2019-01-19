class AddDeletedAtToQuiz < ActiveRecord::Migration[5.2]
  def change
    add_column :quizzes, :deleted_at, :datetime
    add_index :quizzes, :deleted_at

    add_column :quiz_questions, :deleted_at, :datetime
    add_index :quiz_questions, :deleted_at

    add_column :quiz_participations, :deleted_at, :datetime
    add_index :quiz_participations, :deleted_at

    add_column :quiz_answers, :deleted_at, :datetime
    add_index :quiz_answers, :deleted_at

    add_column :quiz_answerings, :deleted_at, :datetime
    add_index :quiz_answerings, :deleted_at
  end
end
