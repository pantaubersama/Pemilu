class AddmaxAlokasiKursiToDapil < ActiveRecord::Migration[5.2]
  def change
    add_column :dapils, :maxAlokasiKursi, :integer
    add_column :dapils, :minAlokasiKursi, :integer
  end
end
