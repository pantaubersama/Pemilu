class ChangeByteOfRange < ActiveRecord::Migration[5.2]
  def change
    change_column :villages, :id, :integer, limit: 8
    change_column :villages, :code, :integer, limit: 8
    change_column :villages, :district_code, :integer, limit: 8
  end
end
