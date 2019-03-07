class CreateHitungCalculations < ActiveRecord::Migration[5.2]
  def change
    create_table :hitung_calculations, id: :uuid do |t|
      t.uuid :hitung_real_count_id
      t.integer :calculation_type
      t.integer :invalid_vote

      t.timestamps
    end
  end
end
