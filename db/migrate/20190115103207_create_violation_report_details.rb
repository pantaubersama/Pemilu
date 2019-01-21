class CreateViolationReportDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :violation_report_details, id: :uuid do |t|
      t.belongs_to :report, type: :uuid, null: false, foreign_key: { to_table: :violation_report_reports }, index: true
      t.string :location, null: false
      t.datetime :occurrence_time, null: false

      t.timestamps
    end
  end
end
