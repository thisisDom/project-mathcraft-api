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

ActiveRecord::Schema.define(version: 20170709211515) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "buildings", force: :cascade do |t|
    t.string "asset_link", null: false
    t.integer "width", default: 1, null: false
    t.integer "height", default: 1, null: false
    t.string "building_class", null: false
    t.integer "building_level", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["asset_link"], name: "index_buildings_on_asset_link", unique: true
  end

  create_table "buildings_resources", force: :cascade do |t|
    t.bigint "resource_id"
    t.bigint "building_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["building_id"], name: "index_buildings_resources_on_building_id"
    t.index ["resource_id"], name: "index_buildings_resources_on_resource_id"
  end

  create_table "experiences", force: :cascade do |t|
    t.integer "level", null: false
    t.integer "experience_needed", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["experience_needed"], name: "index_experiences_on_experience_needed", unique: true
    t.index ["level"], name: "index_experiences_on_level", unique: true
  end

  create_table "levels", force: :cascade do |t|
    t.string "assets", null: false, array: true
    t.integer "position", null: false
    t.text "cards", array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "experience", default: 0
    t.integer "time_limit"
    t.index ["position"], name: "index_levels_on_position", unique: true
  end

  create_table "levels_resources", force: :cascade do |t|
    t.integer "rate"
    t.integer "max_quantity"
    t.integer "min_quantity"
    t.bigint "resource_id"
    t.bigint "level_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["level_id"], name: "index_levels_resources_on_level_id"
    t.index ["resource_id"], name: "index_levels_resources_on_resource_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "username", null: false
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.boolean "login_status", default: true
    t.string "avatar_asset_link"
    t.integer "experience", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_players_on_email_address", unique: true
    t.index ["username"], name: "index_players_on_username", unique: true
  end

  create_table "players_buildings", force: :cascade do |t|
    t.bigint "player_id"
    t.bigint "building_id"
    t.string "location", array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["building_id"], name: "index_players_buildings_on_building_id"
    t.index ["player_id"], name: "index_players_buildings_on_player_id"
  end

  create_table "players_levels", force: :cascade do |t|
    t.bigint "player_id"
    t.bigint "level_id"
    t.datetime "time_started"
    t.datetime "time_completed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["level_id"], name: "index_players_levels_on_level_id"
    t.index ["player_id"], name: "index_players_levels_on_player_id"
  end

  create_table "players_resources", force: :cascade do |t|
    t.bigint "resource_id"
    t.bigint "player_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_players_resources_on_player_id"
    t.index ["resource_id"], name: "index_players_resources_on_resource_id"
  end

  create_table "registered_apps", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_registered_apps_on_email_address", unique: true
  end

  create_table "resources", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "asset_link", null: false
    t.index ["name"], name: "index_resources_on_name", unique: true
  end

end
