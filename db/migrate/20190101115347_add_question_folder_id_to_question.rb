class AddQuestionFolderIdToQuestion < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :question_folder_id, :uuid, index: true
  end
end
