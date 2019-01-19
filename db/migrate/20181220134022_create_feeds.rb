class CreateFeeds < ActiveRecord::Migration[5.2]
  def change
    create_table :feeds, id: :uuid do |t|
      t.bigint :source_id, null: false
      t.text :source_text, null: false
      t.bigint :account_id, null: false
      t.string :account_name, null: false
      t.string :account_username, null: false
      t.string :account_profile_image_url, null: false
      t.uuid :crowling_id, null: false
      t.string :type, null: false
      t.integer :team, null: false
      t.datetime :published_at, null: false

      t.timestamps
    end
    add_index :feeds, [:type, :source_id, :crowling_id], unique: true
  end
end
# Crowling.create(keywords: "pantaubersama")
