class CreateAssetPictures < ActiveRecord::Migration[5.2]
  def change
    create_table :asset_pictures, id: :uuid do |t|
      t.string :picture
      t.string :bucket_title, null: false

      t.timestamps
    end
  end
end
