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

ActiveRecord::Schema.define(version: 2019_01_01_132050) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "banner_infos", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title", null: false
    t.text "body", null: false
    t.string "header_image"
    t.string "image"
    t.string "page_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "crowlings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "keywords", null: false
    t.integer "team", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_crowlings_on_deleted_at"
  end

  create_table "feeds", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "source_id", null: false
    t.text "source_text", null: false
    t.string "account_id", null: false
    t.string "account_name", null: false
    t.string "account_username", null: false
    t.string "account_profile_image_url", null: false
    t.uuid "crowling_id", null: false
    t.string "type", null: false
    t.integer "team", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_feeds_on_deleted_at"
    t.index ["type", "source_id", "crowling_id"], name: "index_feeds_on_type_and_source_id_and_crowling_id", unique: true
  end

  create_table "janji_politiks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title", null: false
    t.text "body", null: false
    t.string "image"
    t.uuid "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_janji_politiks_on_deleted_at"
  end

  create_table "question_folders", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "body", limit: 260
    t.datetime "deleted_at"
    t.uuid "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cached_votes_total", default: 0
    t.integer "cached_votes_score", default: 0
    t.integer "cached_votes_up", default: 0
    t.integer "cached_votes_down", default: 0
    t.integer "cached_weighted_score", default: 0
    t.integer "cached_weighted_total", default: 0
    t.float "cached_weighted_average", default: 0.0
    t.integer "cached_scoped_report_votes_total", default: 0
    t.integer "cached_scoped_report_votes_score", default: 0
    t.integer "cached_scoped_report_votes_up", default: 0
    t.integer "cached_scoped_report_votes_down", default: 0
    t.integer "cached_weighted_report_score", default: 0
    t.integer "cached_weighted_report_total", default: 0
    t.float "cached_weighted_report_average", default: 0.0
    t.uuid "question_folder_id"
    t.index ["deleted_at"], name: "index_questions_on_deleted_at"
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "quiz_answerings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "quiz_participation_id"
    t.uuid "quiz_id"
    t.uuid "quiz_question_id"
    t.uuid "quiz_answer_id"
    t.uuid "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_participation_id", "quiz_question_id"], name: "participating_in_question", unique: true
  end

  create_table "quiz_answers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "team"
    t.text "content"
    t.uuid "quiz_question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_question_id"], name: "index_quiz_answers_on_quiz_question_id"
  end

  create_table "quiz_participations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "quiz_id"
    t.uuid "user_id"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_id"], name: "index_quiz_participations_on_quiz_id"
    t.index ["user_id"], name: "index_quiz_participations_on_user_id"
  end

  create_table "quiz_questions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "content"
    t.uuid "quiz_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quizzes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "image"
    t.integer "quiz_questions_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "seed_migration_data_migrations", id: :serial, force: :cascade do |t|
    t.string "version"
    t.integer "runtime"
    t.datetime "migrated_on"
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.uuid "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  create_table "votes", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "votable_type"
    t.uuid "votable_id"
    t.string "voter_type"
    t.uuid "voter_id"
    t.boolean "vote_flag"
    t.string "vote_scope"
    t.integer "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"
  end

end
