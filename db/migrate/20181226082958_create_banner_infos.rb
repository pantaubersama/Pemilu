class CreateBannerInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :banner_infos, id: :uuid do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.string :header_image
      t.string :image
      t.string :page_name, null: false

      t.timestamps
    end
  end
end
