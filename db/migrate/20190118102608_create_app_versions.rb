class CreateAppVersions < ActiveRecord::Migration[5.2]
  def change
    create_table :app_versions, id: :uuid do |t|
      t.string :name
      t.integer :app_type
      t.boolean :force_update, default: false

      t.timestamps
    end
  end
end
