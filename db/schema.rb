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

ActiveRecord::Schema.define(version: 20160613183127) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "homes", force: :cascade do |t|
    t.string "lat"
    t.string "long"
    t.string "address"
  end

  create_table "homes_pictures", id: false, force: :cascade do |t|
    t.integer "home_id"
    t.integer "picture_id"
  end

  add_index "homes_pictures", ["home_id"], name: "index_homes_pictures_on_home_id", using: :btree
  add_index "homes_pictures", ["picture_id"], name: "index_homes_pictures_on_picture_id", using: :btree

  create_table "pictures", force: :cascade do |t|
    t.string "picture"
    t.string "lat"
    t.string "long"
    t.string "picture_file_name"
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.string   "name"
  end

  create_table "validations", force: :cascade do |t|
    t.integer "home_id"
    t.integer "user_id"
    t.boolean "validated"
  end

  add_index "validations", ["home_id"], name: "index_validations_on_home_id", using: :btree
  add_index "validations", ["user_id"], name: "index_validations_on_user_id", using: :btree

  add_foreign_key "homes_pictures", "homes"
  add_foreign_key "homes_pictures", "pictures"
  add_foreign_key "validations", "homes"
  add_foreign_key "validations", "users"
end
