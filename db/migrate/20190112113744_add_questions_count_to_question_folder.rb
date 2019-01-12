class AddQuestionsCountToQuestionFolder < ActiveRecord::Migration[5.2]
  def change
    add_column :question_folders, :questions_count, :integer, default: 0
  end
end
