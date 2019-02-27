class AddIdParentAndWilayahToDistricts < ActiveRecord::Migration[5.2]
  def change
    add_column :districts, :id_parent, :integer
    add_column :districts, :id_wilayah, :integer
    add_column :districts, :level, :integer
  end
end
