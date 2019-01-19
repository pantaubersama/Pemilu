class AddIsPublisedToQuiz < ActiveRecord::Migration[5.2]
  def change
    add_column :quizzes, :is_published, :boolean, default: false
  end
end
