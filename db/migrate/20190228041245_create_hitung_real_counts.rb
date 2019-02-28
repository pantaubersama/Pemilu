class CreateHitungRealCounts < ActiveRecord::Migration[5.2]
  def change
    create_table :hitung_real_counts, id: :uuid do |t|
      t.integer :tps
      t.bigint :province_code
      t.bigint :regency_code
      t.bigint :district_code
      t.bigint :village_code
      t.integer :status, default: 0
      t.decimal :latitude, precision: 18, scale: 10
      t.decimal :longitude, precision: 18, scale: 10
      t.uuid    :user_id

      t.timestamps
    end
  end
end
