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

ActiveRecord::Schema.define(version: 20150216213209) do

  create_table "bags", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "origin"
    t.decimal  "current_weight",  precision: 16, scale: 4
    t.decimal  "initial_weight",  precision: 16, scale: 4
    t.integer  "history_id"
    t.integer  "container_id"
    t.boolean  "tested",                                   default: false
    t.integer  "lot_id"
    t.string   "datamatrix_text"
    t.string   "datamatrix_hash"
    t.string   "location"
    t.integer  "bin_id"
    t.boolean  "archived",                                 default: false, null: false
    t.decimal  "tare_weight",     precision: 16, scale: 4, default: 0.0,   null: false
    t.integer  "bags_status_id"
    t.boolean  "sent_to_lab",                              default: false, null: false
    t.datetime "packaged_at"
  end

  add_index "bags", ["datamatrix_text", "datamatrix_hash"], name: "index_bags_on_datamatrix_text_and_datamatrix_hash", unique: true

  create_table "bags_statuses", force: true do |t|
    t.string   "name",       default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bags_statuses", ["name"], name: "index_bags_statuses_on_name", unique: true

  create_table "bins", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "location_id"
    t.string   "name"
    t.string   "datamatrix_hash"
    t.string   "datamatrix_text"
  end

  add_index "bins", ["datamatrix_text", "datamatrix_hash"], name: "index_bins_on_datamatrix_text_and_datamatrix_hash", unique: true

  create_table "brands", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "checkouts", force: true do |t|
    t.integer  "target_id",   null: false
    t.string   "target_type", null: false
    t.integer  "user_id",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "checkouts", ["target_id", "target_type"], name: "index_checkouts_on_target_id_and_target_type", unique: true
  add_index "checkouts", ["user_id"], name: "index_checkouts_on_user_id"

  create_table "containers", force: true do |t|
    t.string   "name"
    t.decimal  "current_weight"
    t.decimal  "initial_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "history_id"
    t.string   "category"
    t.integer  "location_id"
    t.string   "type",                                               default: "Container", null: false
    t.integer  "container_id"
    t.datetime "airdrying_stage_ended_at"
    t.datetime "processing_completed_at"
    t.decimal  "processing_waste_produced", precision: 16, scale: 4
    t.decimal  "trim_added",                precision: 16, scale: 4
    t.decimal  "water_loss",                precision: 16, scale: 4
  end

  create_table "containers_lots", force: true do |t|
    t.integer "lot_id"
    t.integer "container_id"
  end

  add_index "containers_lots", ["container_id"], name: "index_containers_lots_on_container_id"
  add_index "containers_lots", ["lot_id"], name: "index_containers_lots_on_lot_id"

  create_table "containers_plants", force: true do |t|
    t.integer "plant_id"
    t.integer "container_id"
  end

  add_index "containers_plants", ["container_id"], name: "index_containers_plants_on_container_id"
  add_index "containers_plants", ["plant_id"], name: "index_containers_plants_on_plant_id"

  create_table "formats", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "harvests", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "histories", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "history_lines", force: true do |t|
    t.integer  "history_id"
    t.integer  "source_id"
    t.string   "source_type"
    t.integer  "target_id"
    t.string   "target_type"
    t.decimal  "quantity",    precision: 16, scale: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "event"
    t.integer  "user_id"
    t.text     "message",                              default: "", null: false
  end

  add_index "history_lines", ["history_id"], name: "index_history_lines_on_history_id"

  create_table "jars", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "bag_id"
    t.string   "name"
    t.integer  "origin"
    t.decimal  "current_weight",  precision: 16, scale: 4
    t.decimal  "initial_weight",  precision: 16, scale: 4
    t.integer  "history_id"
    t.string   "datamatrix_text"
    t.string   "datamatrix_hash"
    t.integer  "order_line_id"
    t.boolean  "fulfilled",                                default: false, null: false
    t.decimal  "tare_weight",     precision: 16, scale: 4, default: 0.0,   null: false
    t.decimal  "ordered_amount",  precision: 16, scale: 4, default: 0.0,   null: false
  end

  add_index "jars", ["datamatrix_text", "datamatrix_hash"], name: "index_jars_on_datamatrix_text_and_datamatrix_hash", unique: true

  create_table "locations", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "plant_ids"
    t.integer  "bin_ids"
    t.integer  "container_ids"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lots", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "category"
    t.integer  "origin"
    t.decimal  "current_weight",  precision: 16, scale: 4
    t.decimal  "initial_weight",  precision: 16, scale: 4
    t.integer  "plant_id"
    t.integer  "history_id"
    t.integer  "strain_id"
    t.decimal  "thc_composition", precision: 5,  scale: 2
    t.decimal  "cbd_composition", precision: 5,  scale: 2
    t.boolean  "recalled",                                 default: false, null: false
    t.boolean  "quarantined",                              default: false, null: false
    t.decimal  "cbn_composition", precision: 5,  scale: 2
  end

  create_table "order_lines", force: true do |t|
    t.decimal  "quantity",   precision: 16, scale: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_id"
    t.integer  "brand_id"
  end

  create_table "orders", force: true do |t|
    t.string   "customer",     default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "ordered_at"
    t.datetime "shipped_at"
    t.integer  "ces_order_id"
    t.string   "created_by",   default: "", null: false
    t.string   "placed_by",    default: "", null: false
  end

  add_index "orders", ["ces_order_id"], name: "index_orders_on_ces_order_id", unique: true

  create_table "plants", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lot_id"
    t.integer  "strain_id"
    t.integer  "format_id"
    t.integer  "status_id"
    t.integer  "rfid_id"
    t.string   "name"
    t.integer  "history_id"
    t.decimal  "current_weight",      precision: 16, scale: 4
    t.decimal  "initial_weight",      precision: 16, scale: 4
    t.integer  "location_id"
    t.datetime "partial_harvest_at"
    t.datetime "complete_harvest_at"
    t.string   "type",                                         default: "Plant", null: false
    t.integer  "plant_id"
    t.integer  "seed_id"
    t.string   "datamatrix_hash"
    t.string   "datamatrix_text"
    t.datetime "destroyed_at"
    t.datetime "harvested_at"
  end

  add_index "plants", ["datamatrix_text", "datamatrix_hash"], name: "index_plants_on_datamatrix_text_and_datamatrix_hash", unique: true
  add_index "plants", ["format_id"], name: "index_plants_on_format_id"
  add_index "plants", ["rfid_id"], name: "index_plants_on_rfid_id"
  add_index "plants", ["seed_id"], name: "index_plants_on_seed_id"
  add_index "plants", ["status_id"], name: "index_plants_on_status_id"
  add_index "plants", ["strain_id"], name: "index_plants_on_strain_id"

  create_table "rfids", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "seeds", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "initial_weight",  precision: 16, scale: 4
    t.decimal  "current_weight",  precision: 16, scale: 4
    t.integer  "stock"
    t.string   "datamatrix_text"
    t.string   "datamatrix_hash"
    t.integer  "history_id"
  end

  add_index "seeds", ["datamatrix_text", "datamatrix_hash"], name: "index_seeds_on_datamatrix_text_and_datamatrix_hash", unique: true

  create_table "statuses", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "strains", force: true do |t|
    t.string   "name"
    t.string   "acronym"
    t.string   "info"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "brand_id"
    t.string   "description"
  end

  create_table "transactions", force: true do |t|
    t.datetime "event",                                null: false
    t.integer  "source_id"
    t.string   "source_type"
    t.integer  "target_id"
    t.string   "target_type"
    t.decimal  "weight",      precision: 16, scale: 4, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "transactions", ["source_id", "source_type"], name: "index_transactions_on_source_id_and_source_type"
  add_index "transactions", ["target_id", "target_type"], name: "index_transactions_on_target_id_and_target_type"

  create_table "user_group_roles", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "manager",    default: false
    t.boolean  "admin",      default: false
    t.string   "name"
  end

  create_table "user_groups", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_group_role_id"
    t.string   "name"
  end

  create_table "user_roles", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "manager",    default: false
    t.boolean  "admin",      default: false
    t.string   "name"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                     default: "", null: false
    t.string   "encrypted_password",        default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",             default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "user_group_id"
    t.integer  "user_role_id"
    t.string   "provider",                  default: "", null: false
    t.string   "uid",                       default: "", null: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.text     "tokens"
    t.integer  "temporary_role_id"
    t.datetime "temporary_role_expires_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "wastes", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
