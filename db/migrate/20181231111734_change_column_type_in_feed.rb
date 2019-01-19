class ChangeColumnTypeInFeed < ActiveRecord::Migration[5.2]
  def change
    change_column :feeds, :source_id, :string
    change_column :feeds, :account_id, :string
  end
end
