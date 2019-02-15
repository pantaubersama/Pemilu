class AddFeedsCounts < ActiveRecord::Migration[5.2]
  def self.up
    add_column :crowlings, :feeds_count, :integer, default: 0
    
    Crowling.find_each do |crow|
      Crowling.reset_counters(crow.id, :feeds)
    end
  end

  def self.down
    remove_column :crowlings, :feeds_count
  end
end
