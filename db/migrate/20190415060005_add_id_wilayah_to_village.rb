class AddIdWilayahToVillage < ActiveRecord::Migration[5.2]
  def change
    add_column :villages, :id_wilayah, :integer
  end
end
