class AddDeletedAtToCrowling < ActiveRecord::Migration[5.2]
  def change
    add_column :crowlings, :deleted_at, :datetime
    add_index :crowlings, :deleted_at

    add_column :feeds, :deleted_at, :datetime
    add_index :feeds, :deleted_at
  end
end
