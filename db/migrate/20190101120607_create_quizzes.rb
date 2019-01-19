class CreateQuizzes < ActiveRecord::Migration[5.2]
  def change
    create_table :quizzes, id: :uuid do |t|
      t.string :title
      t.text :description
      t.string :image
      t.integer :quiz_questions_count, default: 0

      t.timestamps
    end
  end
end
