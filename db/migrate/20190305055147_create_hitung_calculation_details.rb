class CreateHitungCalculationDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :hitung_calculation_details, id: :uuid do |t|
      t.uuid :hitung_real_count_id
      t.uuid :hitung_calculation_id
      t.string :actor_type
      t.string :actor_id
      t.integer :total_vote

      t.timestamps
    end
  end
end
