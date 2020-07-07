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

ActiveRecord::Schema.define(version: 2020_07_04_105251) do

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "entries", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "request_id", null: false
    t.string "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "evaluations", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "request_id", null: false
    t.float "rate"
    t.string "comment"
    t.boolean "status", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "request_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "joins", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "room_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "room_id", null: false
    t.string "body", null: false
    t.boolean "checked", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "visitor_id", null: false
    t.integer "visited_id", null: false
    t.integer "request_id"
    t.integer "message_id"
    t.integer "scout_id"
    t.integer "entry_id"
    t.string "action", null: false
    t.boolean "checked", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "participants", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "request_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id", null: false
    t.integer "followed_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "request_genres", force: :cascade do |t|
    t.string "category", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "requests", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "request_genre_id", null: false
    t.string "title", null: false
    t.text "content", null: false
    t.integer "reward", null: false
    t.datetime "recruiment_end", null: false
    t.datetime "delivery_date", null: false
    t.datetime "completion"
    t.integer "recruiment_max", null: false
    t.integer "status", limit: 1, default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title"], name: "index_requests_on_title"
  end

  create_table "rooms", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scouts", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "request_id", null: false
    t.string "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "skill_sets", force: :cascade do |t|
    t.integer "possible_id"
    t.integer "good_id"
    t.integer "necessary_id"
    t.integer "skill_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "skills", force: :cascade do |t|
    t.string "item", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "desired_reward"
    t.string "strong_point"
    t.text "introduction"
    t.string "profile_image_id"
    t.integer "status", limit: 1, default: 0, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
