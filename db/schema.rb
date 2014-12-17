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

ActiveRecord::Schema.define(version: 20141217191533) do

  create_table "bags", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lot_id"
    t.string   "name"
    t.integer  "weight"
  end

  create_table "cultivars", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "formats", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "jars", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "bag_id"
    t.string   "name"
    t.integer  "weight"
  end

  create_table "lots", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "weight"
  end

  create_table "plants", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lot_id"
    t.integer  "cultivar_id"
    t.integer  "format_id"
    t.integer  "status_id"
    t.integer  "rfid_id"
    t.string   "origin"
    t.string   "name"
  end

  add_index "plants", ["cultivar_id"], name: "index_plants_on_cultivar_id"
  add_index "plants", ["format_id"], name: "index_plants_on_format_id"
  add_index "plants", ["rfid_id"], name: "index_plants_on_rfid_id"
  add_index "plants", ["status_id"], name: "index_plants_on_status_id"

  create_table "rfids", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "statuses", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "user_groups", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_roles", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
