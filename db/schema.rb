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

ActiveRecord::Schema.define(version: 2019_02_27_081720) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "app_versions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.integer "app_type"
    t.boolean "force_update", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "version_code"
  end

  create_table "banner_infos", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title", null: false
    t.text "body", null: false
    t.string "header_image"
    t.string "image"
    t.string "page_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "candidates", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "gender"
    t.integer "political_party_id"
    t.integer "electoral_district_id"
    t.integer "serial_number"
    t.string "original_filename"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "crowlings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "keywords", null: false
    t.integer "team", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.integer "feeds_count", default: 0
    t.index ["deleted_at"], name: "index_crowlings_on_deleted_at"
  end

  create_table "dapil_wilayahs", id: :serial, force: :cascade do |t|
    t.integer "idDapil"
    t.integer "idWilayah"
    t.string "namaWilayah"
    t.integer "urutanWilayahDapil"
    t.boolean "flagInclude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id"], name: "index_dapil_wilayahs_on_id", unique: true
    t.index ["idDapil"], name: "index_dapil_wilayahs_on_idDapil"
    t.index ["idWilayah"], name: "index_dapil_wilayahs_on_idWilayah"
  end

  create_table "dapils", id: :serial, force: :cascade do |t|
    t.string "nama"
    t.integer "tingkat"
    t.string "jumlahPenduduk"
    t.integer "idWilayah"
    t.integer "totalAlokasiKursi"
    t.integer "idVersi"
    t.integer "noDapil"
    t.boolean "statusCoterminous"
    t.integer "idPro"
    t.integer "parent"
    t.integer "alokasiKursi"
    t.integer "sisaPenduduk"
    t.integer "peringkatPenduduk"
    t.integer "alokasiSisaKursi"
    t.decimal "stdDev"
    t.decimal "mean"
    t.integer "dapilOwner"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "maxAlokasiKursi"
    t.integer "minAlokasiKursi"
    t.index ["id"], name: "index_dapils_on_id", unique: true
    t.index ["idPro"], name: "index_dapils_on_idPro"
    t.index ["idVersi"], name: "index_dapils_on_idVersi"
    t.index ["idWilayah"], name: "index_dapils_on_idWilayah"
    t.index ["parent"], name: "index_dapils_on_parent"
  end

  create_table "districts", id: :serial, force: :cascade do |t|
    t.integer "code"
    t.integer "regency_code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "id_parent"
    t.integer "id_wilayah"
    t.integer "level"
    t.index ["id"], name: "index_districts_on_id", unique: true
    t.index ["regency_code"], name: "index_districts_on_regency_code"
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
    t.text "source_media"
    t.index ["deleted_at"], name: "index_feeds_on_deleted_at"
    t.index ["type", "source_id", "crowling_id"], name: "index_feeds_on_type_and_source_id_and_crowling_id", unique: true
  end

  create_table "janji_politiks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title", null: false
    t.text "body", null: false
    t.uuid "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.string "image"
    t.index ["deleted_at"], name: "index_janji_politiks_on_deleted_at"
  end

  create_table "kenalans", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "text", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "link"
  end

  create_table "political_parties", id: :serial, force: :cascade do |t|
    t.integer "serial_number"
    t.string "name"
    t.string "description"
    t.string "acronym"
    t.string "logo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "provinces", id: :serial, force: :cascade do |t|
    t.integer "code", null: false
    t.string "name"
    t.integer "level"
    t.string "domain_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "id_wilayah"
  end

  create_table "question_folders", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "questions_count", default: 0
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_question_folders_on_deleted_at"
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
    t.integer "status", default: 0
    t.decimal "temperature", precision: 18, scale: 10
    t.datetime "last_temperature_at"
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
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_quiz_answerings_on_deleted_at"
    t.index ["quiz_participation_id", "quiz_question_id"], name: "participating_in_question", unique: true
  end

  create_table "quiz_answers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "team"
    t.text "content"
    t.uuid "quiz_question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_quiz_answers_on_deleted_at"
    t.index ["quiz_question_id"], name: "index_quiz_answers_on_quiz_question_id"
  end

  create_table "quiz_participations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "quiz_id"
    t.uuid "user_id"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.string "image_result"
    t.index ["deleted_at"], name: "index_quiz_participations_on_deleted_at"
    t.index ["quiz_id"], name: "index_quiz_participations_on_quiz_id"
    t.index ["user_id"], name: "index_quiz_participations_on_user_id"
  end

  create_table "quiz_preferences", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.string "image_result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quiz_questions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "content"
    t.uuid "quiz_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_quiz_questions_on_deleted_at"
  end

  create_table "quizzes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "image"
    t.integer "quiz_questions_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_published", default: false
    t.datetime "deleted_at"
    t.integer "status"
    t.index ["deleted_at"], name: "index_quizzes_on_deleted_at"
  end

  create_table "regencies", id: :serial, force: :cascade do |t|
    t.integer "province_id", null: false
    t.integer "code", null: false
    t.string "name"
    t.integer "level"
    t.string "domain_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "id_wilayah"
    t.integer "id_parent"
    t.index ["province_id"], name: "index_regencies_on_province_id"
  end

  create_table "seed_migration_data_migrations", id: :integer, default: nil, force: :cascade do |t|
    t.string "version"
    t.integer "runtime"
    t.datetime "migrated_on"
  end

  create_table "user_kenalans", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "kenalan_id", null: false
    t.datetime "action_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "kenalan_id"], name: "index_user_kenalans_on_user_id_and_kenalan_id", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.uuid "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.text "object_changes"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  create_table "villages", force: :cascade do |t|
    t.bigint "code"
    t.bigint "district_code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["district_code"], name: "index_villages_on_district_code"
    t.index ["id"], name: "index_villages_on_id", unique: true
  end

  create_table "violation_report_details", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "report_id", null: false
    t.string "location", null: false
    t.datetime "occurrence_time", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["report_id"], name: "index_violation_report_details_on_report_id"
  end

  create_table "violation_report_evidences", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "detail_id", null: false
    t.string "file", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["detail_id"], name: "index_violation_report_evidences_on_detail_id"
  end

  create_table "violation_report_parties", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "type", null: false
    t.uuid "detail_id", null: false
    t.string "name", null: false
    t.text "address", null: false
    t.string "telephone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["detail_id"], name: "index_violation_report_parties_on_detail_id"
    t.index ["type"], name: "index_violation_report_parties_on_type"
  end

  create_table "violation_report_reports", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "reporter_id", null: false
    t.uuid "dimension_id", null: false
    t.string "title", null: false
    t.text "description", null: false
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
    t.index ["dimension_id"], name: "index_violation_report_reports_on_dimension_id"
    t.index ["reporter_id"], name: "index_violation_report_reports_on_reporter_id"
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

  add_foreign_key "violation_report_details", "violation_report_reports", column: "report_id"
  add_foreign_key "violation_report_evidences", "violation_report_details", column: "detail_id"
  add_foreign_key "violation_report_parties", "violation_report_details", column: "detail_id"
end
