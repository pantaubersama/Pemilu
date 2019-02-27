class AddIdWilayahToRegency < ActiveRecord::Migration[5.2]
  def change
    add_column :regencies, :id_wilayah, :integer
  end
end
