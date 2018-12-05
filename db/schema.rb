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

ActiveRecord::Schema.define(version: 2018_12_05_201714) do

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.boolean "is_parent"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "parent_team_id"
    t.integer "manager_id"
    t.index ["manager_id"], name: "index_teams_on_manager_id"
    t.index ["parent_team_id"], name: "index_teams_on_parent_team_id"
  end

  create_table "user_badges", force: :cascade do |t|
    t.integer "user_id"
    t.integer "badge"
    t.string "name"
    t.string "src"
    t.text "description"
    t.boolean "active"
    t.integer "issued_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["badge"], name: "index_user_badges_on_badge"
    t.index ["issued_by_id"], name: "index_user_badges_on_issued_by_id"
    t.index ["user_id"], name: "index_user_badges_on_user_id"
  end

  create_table "user_skills", force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.integer "level"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_skills_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "title"
    t.integer "tier"
    t.integer "team_id"
    t.string "email"
    t.string "slack"
    t.text "bio"
    t.boolean "is_manager"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "manager_id"
    t.date "started_at"
    t.index ["manager_id"], name: "index_users_on_manager_id"
    t.index ["team_id"], name: "index_users_on_team_id"
  end

end
