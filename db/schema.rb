# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2026_01_17_042736) do
  create_table "item_logs", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "item_id", null: false
    t.string "action", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_item_logs_on_item_id"
    t.index ["user_id"], name: "index_item_logs_on_user_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name", null: false
    t.integer "price", null: false
    t.string "effect_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_name", null: false
  end

  create_table "login_logs", force: :cascade do |t|
    t.integer "user_id", null: false
    t.date "login_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_login_logs_on_user_id"
  end

  create_table "quest_logs", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "title", null: false
    t.integer "exp", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_quest_logs_on_user_id"
  end

  create_table "quests", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "exp_reward"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category"
    t.string "subcategory"
    t.string "difficulty"
    t.date "due_date"
    t.index ["due_date"], name: "index_quests_on_due_date"
    t.index ["user_id"], name: "index_quests_on_user_id"
  end

  create_table "user_items", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "item_id", null: false
    t.integer "quantity", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_user_items_on_item_id"
    t.index ["user_id", "item_id"], name: "index_user_items_on_user_id_and_item_id", unique: true
    t.index ["user_id"], name: "index_user_items_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "level", default: 1
    t.integer "exp", default: 0
    t.string "avatar_type", default: "warrior"
    t.integer "hp", default: 100
    t.integer "mp", default: 30
    t.integer "str", default: 10
    t.integer "vit", default: 10
    t.integer "battle_stage", default: 1
    t.integer "battle_position", default: 1
    t.integer "stage_exp", default: 0
    t.integer "current_hp"
    t.datetime "last_hp_ticked_at"
    t.integer "total_exp", default: 0, null: false
    t.integer "coins", default: 0, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "item_logs", "items"
  add_foreign_key "item_logs", "users"
  add_foreign_key "login_logs", "users"
  add_foreign_key "quest_logs", "users"
  add_foreign_key "quests", "users"
  add_foreign_key "user_items", "items"
  add_foreign_key "user_items", "users"
end
