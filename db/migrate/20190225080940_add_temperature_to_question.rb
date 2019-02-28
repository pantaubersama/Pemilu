class AddTemperatureToQuestion < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :temperature, :decimal, precision: 18, scale: 10
    add_column :questions, :last_temperature_at, :datetime
  end
end
