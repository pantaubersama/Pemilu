class RemoveImageInJanjiPolitiks < ActiveRecord::Migration[5.2]
  def change
    remove_column :janji_politiks, :image
  end
end
