class CreateRequestData < ActiveRecord::Migration[5.2]
  def change
    create_table :request_data, id: :uuid do |t|
      t.string :name
      t.string :organization
      t.string :email
      t.string :phone
      t.text :necessity

      t.timestamps
    end
  end
end
