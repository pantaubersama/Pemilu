class CreateViolationReportReports < ActiveRecord::Migration[5.2]
  def change
    create_table :violation_report_reports, id: :uuid do |t|
      t.belongs_to :reporter, type: :uuid, null: false, index: true
      t.belongs_to :dimension, type: :uuid, null: false, index: true
      t.string :title, null: false
      t.text :description, null: false

      t.timestamps
    end
  end
end
