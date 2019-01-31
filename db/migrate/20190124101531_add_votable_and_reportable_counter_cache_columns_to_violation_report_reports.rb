class AddVotableAndReportableCounterCacheColumnsToViolationReportReports < ActiveRecord::Migration[5.2]
  def change
    change_table :violation_report_reports do |t|
      # Votable
      t.integer :cached_votes_total, default: 0
      t.integer :cached_votes_score, default: 0
      t.integer :cached_votes_up, default: 0
      t.integer :cached_votes_down, default: 0
      t.integer :cached_weighted_score, default: 0
      t.integer :cached_weighted_total, default: 0
      t.float :cached_weighted_average, default: 0.0

      # Reportable
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
