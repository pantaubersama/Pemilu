class AddImageToJanjiPolitiks < ActiveRecord::Migration[5.2]
  def change
    add_column :janji_politiks, :image, :string
    drop_table :asset_pictures
  end
end
