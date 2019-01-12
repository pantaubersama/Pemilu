class AddStatusToQuiz < ActiveRecord::Migration[5.2]
  def change
    add_column :quizzes, :status, :integer
  end
end
