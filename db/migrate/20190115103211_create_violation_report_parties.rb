class CreateViolationReportParties < ActiveRecord::Migration[5.2]
  def change
    create_table :violation_report_parties, id: :uuid do |t|
      t.string :type, null: false, index: true
      t.belongs_to :detail, type: :uuid, null: false, foreign_key: { to_table: :violation_report_details }, index: true
      t.string :name, null: false
      t.text :address, null: false
      t.string :telephone_number

      t.timestamps
    end
  end
end
