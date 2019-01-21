class CreateViolationReportEvidences < ActiveRecord::Migration[5.2]
  def change
    create_table :violation_report_evidences, id: :uuid do |t|
      t.belongs_to :detail, type: :uuid, null: false, foreign_key: { to_table: :violation_report_details }, index: true
      t.string :file, null: false

      t.timestamps
    end
  end
end
