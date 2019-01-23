class AddMediaToFeeds < ActiveRecord::Migration[5.2]
  def change
    add_column :feeds, :source_media, :text
  end
end
