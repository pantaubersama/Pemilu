class AddIdWilayahToProvince < ActiveRecord::Migration[5.2]
  def change
    add_column :provinces, :id_wilayah, :integer
  end
end
