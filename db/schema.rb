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

ActiveRecord::Schema.define(version: 20181113010700) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.integer  "question_id"
    t.text     "text"
    t.text     "short_text"
    t.text     "help_text"
    t.integer  "weight"
    t.string   "response_class"
    t.string   "default_value"
    t.string   "input_mask"
    t.string   "input_mask_placeholder"
    t.string   "reference_identifier"
    t.string   "data_export_identifier"
    t.string   "common_namespace"
    t.string   "common_identifier"
    t.string   "api_id"
    t.integer  "display_order"
    t.boolean  "is_exclusive"
    t.boolean  "hide_label"
    t.integer  "display_length"
    t.string   "display_type"
    t.string   "custom_class"
    t.string   "custom_renderer"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["api_id"], name: "index_answers_on_api_id", unique: true, using: :btree
  end

  create_table "campaign_files", force: :cascade do |t|
    t.string   "name"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.bigint   "file_file_size"
    t.datetime "file_updated_at"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.string   "short_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories_organizations", id: false, force: :cascade do |t|
    t.integer "organization_id", null: false
    t.integer "category_id",     null: false
    t.index ["category_id"], name: "index_categories_organizations_on_category_id", using: :btree
    t.index ["organization_id"], name: "index_categories_organizations_on_organization_id", using: :btree
  end

  create_table "dependencies", force: :cascade do |t|
    t.integer  "question_id"
    t.integer  "question_group_id"
    t.string   "rule"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "dependency_conditions", force: :cascade do |t|
    t.integer  "dependency_id"
    t.string   "rule_key"
    t.integer  "question_id"
    t.string   "operator"
    t.integer  "answer_id"
    t.datetime "datetime_value"
    t.integer  "integer_value"
    t.float    "float_value"
    t.string   "unit"
    t.text     "text_value"
    t.string   "string_value"
    t.string   "response_other"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "leadup_date"
    t.datetime "followup_date"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "interests", force: :cascade do |t|
    t.string "text"
    t.string "short_text"
  end

  create_table "interests_users", id: false, force: :cascade do |t|
    t.integer "user_id",     null: false
    t.integer "interest_id", null: false
    t.index ["interest_id"], name: "index_interests_users_on_interest_id", using: :btree
    t.index ["user_id"], name: "index_interests_users_on_user_id", using: :btree
  end

  create_table "organizations", force: :cascade do |t|
    t.string   "name"
    t.string   "short_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "url"
    t.index ["name"], name: "index_organizations_on_name", using: :btree
    t.index ["short_name"], name: "index_organizations_on_short_name", using: :btree
  end

  create_table "question_groups", force: :cascade do |t|
    t.text     "text"
    t.text     "help_text"
    t.string   "reference_identifier"
    t.string   "data_export_identifier"
    t.string   "common_namespace"
    t.string   "common_identifier"
    t.string   "api_id"
    t.string   "display_type"
    t.string   "custom_class"
    t.string   "custom_renderer"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["api_id"], name: "index_question_groups_on_api_id", unique: true, using: :btree
  end

  create_table "questions", force: :cascade do |t|
    t.integer  "survey_section_id"
    t.integer  "question_group_id"
    t.text     "text"
    t.text     "short_text"
    t.text     "help_text"
    t.string   "pick"
    t.integer  "correct_answer_id"
    t.string   "reference_identifier"
    t.string   "data_export_identifier"
    t.string   "common_namespace"
    t.string   "common_identifier"
    t.string   "api_id"
    t.integer  "display_order"
    t.string   "display_type"
    t.boolean  "is_mandatory"
    t.integer  "display_width"
    t.string   "custom_class"
    t.string   "custom_renderer"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["api_id"], name: "index_questions_on_api_id", unique: true, using: :btree
  end

  create_table "response_sets", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "survey_id"
    t.string   "access_code"
    t.string   "api_id"
    t.datetime "started_at"
    t.datetime "completed_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["access_code"], name: "index_response_sets_on_access_code", unique: true, using: :btree
    t.index ["api_id"], name: "index_response_sets_on_api_id", unique: true, using: :btree
  end

  create_table "responses", force: :cascade do |t|
    t.integer  "survey_section_id"
    t.integer  "response_set_id"
    t.integer  "question_id"
    t.integer  "answer_id"
    t.datetime "datetime_value"
    t.integer  "integer_value"
    t.float    "float_value"
    t.string   "unit"
    t.text     "text_value"
    t.string   "string_value"
    t.string   "response_other"
    t.string   "response_group"
    t.string   "api_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["api_id"], name: "index_responses_on_api_id", unique: true, using: :btree
    t.index ["survey_section_id"], name: "index_responses_on_survey_section_id", using: :btree
  end

  create_table "survey_sections", force: :cascade do |t|
    t.integer  "survey_id"
    t.string   "title"
    t.text     "description"
    t.string   "reference_identifier"
    t.string   "data_export_identifier"
    t.string   "common_namespace"
    t.string   "common_identifier"
    t.string   "custom_class"
    t.integer  "display_order"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "survey_translations", force: :cascade do |t|
    t.integer  "survey_id"
    t.string   "locale"
    t.text     "translation"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "surveys", force: :cascade do |t|
    t.string   "type"
    t.integer  "event_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "title"
    t.text     "description"
    t.string   "access_code"
    t.string   "reference_identifier"
    t.string   "data_export_identifier"
    t.string   "common_namespace"
    t.string   "common_identifier"
    t.integer  "survey_version",         default: 0
    t.string   "api_id"
    t.datetime "active_at"
    t.datetime "inactive_at"
    t.string   "css_url"
    t.string   "custom_class"
    t.integer  "display_order"
    t.index ["access_code", "survey_version"], name: "surveys_access_code_version_idx", unique: true, using: :btree
    t.index ["api_id"], name: "index_surveys_on_api_id", unique: true, using: :btree
    t.index ["event_id"], name: "index_surveys_on_event_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string "text"
    t.string "short_text"
  end

  create_table "tags_users", id: false, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "tag_id",  null: false
    t.index ["tag_id"], name: "index_tags_users_on_tag_id", using: :btree
    t.index ["user_id"], name: "index_tags_users_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "short_name"
    t.string   "pronoun"
    t.boolean  "active",                 default: true
    t.boolean  "admin"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.integer  "organization_id"
    t.string   "phone"
    t.string   "city"
    t.text     "notes"
    t.text     "admin_notes"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "validation_conditions", force: :cascade do |t|
    t.integer  "validation_id"
    t.string   "rule_key"
    t.string   "operator"
    t.integer  "question_id"
    t.integer  "answer_id"
    t.datetime "datetime_value"
    t.integer  "integer_value"
    t.float    "float_value"
    t.string   "unit"
    t.text     "text_value"
    t.string   "string_value"
    t.string   "response_other"
    t.string   "regexp"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "validations", force: :cascade do |t|
    t.integer  "answer_id"
    t.string   "rule"
    t.string   "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
