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

ActiveRecord::Schema.define(version: 20180118180102) do

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups_users", id: false, force: :cascade do |t|
    t.integer "group_id", null: false
    t.integer "user_id", null: false
    t.index ["group_id", "user_id"], name: "index_groups_users_on_group_id_and_user_id", unique: true
    t.index ["user_id", "group_id"], name: "index_groups_users_on_user_id_and_group_id", unique: true
  end

  create_table "responses", force: :cascade do |t|
    t.integer "value"
    t.text "note"
    t.integer "sendee_id"
    t.integer "sub_request_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sendee_id"], name: "index_responses_on_sendee_id"
    t.index ["sub_request_id"], name: "index_responses_on_sub_request_id"
  end

  create_table "sendees", force: :cascade do |t|
    t.boolean "sub"
    t.integer "sub_request_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sub_request_id"], name: "index_sendees_on_sub_request_id"
    t.index ["user_id"], name: "index_sendees_on_user_id"
  end

  create_table "sub_requests", force: :cascade do |t|
    t.date "date"
    t.string "class_name"
    t.integer "class_id_mb"
    t.text "note"
    t.integer "group_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_sub_requests_on_group_id"
    t.index ["user_id"], name: "index_sub_requests_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.integer "staff_id_mb"
    t.string "first_name"
    t.string "last_name"
    t.string "login_location"
    t.string "email"
    t.integer "mobile_phone"
    t.integer "home_phone"
    t.integer "work_phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
