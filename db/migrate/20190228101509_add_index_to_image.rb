class AddIndexToImage < ActiveRecord::Migration[5.2]
  def change
    add_index :hitung_images, :hitung_real_count_id
  end
end
