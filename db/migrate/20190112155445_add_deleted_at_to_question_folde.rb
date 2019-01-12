class AddDeletedAtToQuestionFolde < ActiveRecord::Migration[5.2]
  def change
    add_column :question_folders, :deleted_at, :datetime
    add_index :question_folders, :deleted_at
  end
end
