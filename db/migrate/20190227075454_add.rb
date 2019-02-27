class Add < ActiveRecord::Migration[5.2]
  def change
    add_column :regencies, :id_parent, :integer
  end
end
