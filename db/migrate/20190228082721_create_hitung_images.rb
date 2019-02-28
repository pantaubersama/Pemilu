class CreateHitungImages < ActiveRecord::Migration[5.2]
  def change
    create_table :hitung_images, id: :uuid do |t|
      t.string :file
      t.integer :image_type
      t.uuid :hitung_real_count_id
      t.timestamps
    end
  end
end
