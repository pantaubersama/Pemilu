class AddReportCounterCache < ActiveRecord::Migration[5.2]
  def change
    change_table :questions do |t|
      t.integer :cached_scoped_report_votes_total, default: 0
      t.integer :cached_scoped_report_votes_score, default: 0
      t.integer :cached_scoped_report_votes_up, default: 0
      t.integer :cached_scoped_report_votes_down, default: 0
      t.integer :cached_weighted_report_score, default: 0
      t.integer :cached_weighted_report_total, default: 0
      t.float :cached_weighted_report_average, default: 0.0
    end
  end
end
