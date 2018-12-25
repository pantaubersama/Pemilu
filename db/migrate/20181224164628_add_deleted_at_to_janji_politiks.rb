class AddDeletedAtToJanjiPolitiks < ActiveRecord::Migration[5.2]
  def change
    add_column :janji_politiks, :deleted_at, :datetime
    add_index :janji_politiks, :deleted_at
  end
end
