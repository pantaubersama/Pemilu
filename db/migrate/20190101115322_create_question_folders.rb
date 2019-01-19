class CreateQuestionFolders < ActiveRecord::Migration[5.2]
  def change
    create_table :question_folders, id: :uuid do |t|
      t.string :name

      t.timestamps
    end
  end
end
