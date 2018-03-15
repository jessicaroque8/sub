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

ActiveRecord::Schema.define(version: 20180307200632) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "groups", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups_users", id: false, force: :cascade do |t|
    t.bigint "group_id", null: false
    t.bigint "user_id", null: false
    t.index ["group_id", "user_id"], name: "index_groups_users_on_group_id_and_user_id", unique: true
    t.index ["user_id", "group_id"], name: "index_groups_users_on_user_id_and_group_id", unique: true
  end

  create_table "replies", force: :cascade do |t|
    t.integer "value", default: 0, null: false
    t.text "note"
    t.bigint "sendee_id"
    t.bigint "sub_request_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sendee_id"], name: "index_replies_on_sendee_id"
    t.index ["sub_request_id"], name: "index_replies_on_sub_request_id"
  end

  create_table "selected_subs", force: :cascade do |t|
    t.boolean "confirmed", default: false
    t.bigint "sub_request_id"
    t.bigint "sendee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sendee_id"], name: "index_selected_subs_on_sendee_id"
    t.index ["sub_request_id"], name: "index_selected_subs_on_sub_request_id"
  end

  create_table "sendees", force: :cascade do |t|
    t.bigint "sub_request_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sub_request_id"], name: "index_sendees_on_sub_request_id"
    t.index ["user_id"], name: "index_sendees_on_user_id"
  end

  create_table "sub_requests", force: :cascade do |t|
    t.datetime "start_date_time", null: false
    t.datetime "end_date_time"
    t.string "class_name"
    t.integer "class_id_mb"
    t.text "note"
    t.bigint "group_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "closed", default: false
    t.index ["group_id"], name: "index_sub_requests_on_group_id"
    t.index ["user_id"], name: "index_sub_requests_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.integer "staff_id_mb"
    t.string "first_name"
    t.string "last_name"
    t.string "image"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.text "tokens"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "replies", "sendees"
  add_foreign_key "replies", "sub_requests"
  add_foreign_key "selected_subs", "sendees"
  add_foreign_key "selected_subs", "sub_requests"
  add_foreign_key "sendees", "sub_requests"
  add_foreign_key "sendees", "users"
  add_foreign_key "sub_requests", "groups"
  add_foreign_key "sub_requests", "users"
end
