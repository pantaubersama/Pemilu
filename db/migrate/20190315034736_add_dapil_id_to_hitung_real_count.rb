class AddDapilIdToHitungRealCount < ActiveRecord::Migration[5.2]
  def change
    add_column :hitung_calculations, :dapil_id, :integer
  end
end
