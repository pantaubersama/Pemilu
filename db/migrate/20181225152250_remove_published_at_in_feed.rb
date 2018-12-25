class RemovePublishedAtInFeed < ActiveRecord::Migration[5.2]
  def change
    remove_column :feeds, :published_at
  end
end
