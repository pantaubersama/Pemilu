class AddFeedsCounts < ActiveRecord::Migration[5.2]
  def self.up
    add_column :crowlings, :feeds_count, :integer, default: 0
    
    Crowling.reset_column_information
    Crowling.all.each do |crow|
      crow.update_attribute :feeds_count, crow.feeds.length
    end
  end

  def self.down
    remove_column :crowlings, :feeds_count
  end
end
