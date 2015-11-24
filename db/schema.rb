# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151124142702) do

  create_table "sessions", force: :cascade do |t|
    t.integer  "user_id",           limit: 4
    t.string   "ip_address",        limit: 255
    t.datetime "last_session_date"
  end

  add_index "sessions", ["user_id"], name: "index_sessions_on_user_id", using: :btree

  create_table "tasks", force: :cascade do |t|
    t.text     "description",     limit: 65535, null: false
    t.integer  "priority",        limit: 4,     null: false
    t.datetime "expiration_date"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "user_id",         limit: 4
  end

  add_index "tasks", ["user_id"], name: "index_tasks_on_user_id", using: :btree

  create_table "time_sheets", force: :cascade do |t|
    t.datetime "clock_in"
    t.datetime "clock_out"
    t.integer  "total_minutes", limit: 4
    t.text     "work_report",   limit: 65535
    t.datetime "report_date"
    t.string   "ip_address",    limit: 50
    t.integer  "user_id",       limit: 4
  end

  add_index "time_sheets", ["user_id"], name: "index_time_sheets_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username",        limit: 30,              null: false
    t.string   "email",           limit: 30,              null: false
    t.string   "password_digest", limit: 255
    t.string   "first_name",      limit: 30,              null: false
    t.string   "last_name",       limit: 30,              null: false
    t.string   "phone_number",    limit: 20
    t.string   "title",           limit: 30
    t.string   "timezone",        limit: 50
    t.integer  "role",            limit: 4,   default: 0, null: false
    t.integer  "status",          limit: 4,   default: 0, null: false
    t.datetime "archived_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "tasks", "users"
  add_foreign_key "time_sheets", "users"
end
