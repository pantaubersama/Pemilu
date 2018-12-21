# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_12_20_134022) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "crowlings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "keywords", null: false
    t.integer "team", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "feeds", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "source_id", null: false
    t.text "source_text", null: false
    t.bigint "account_id", null: false
    t.string "account_name", null: false
    t.string "account_username", null: false
    t.string "account_profile_image_url", null: false
    t.uuid "crowling_id", null: false
    t.string "type", null: false
    t.integer "team", null: false
    t.datetime "published_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type", "source_id", "crowling_id"], name: "index_feeds_on_type_and_source_id_and_crowling_id", unique: true
  end

end
