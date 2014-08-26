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

ActiveRecord::Schema.define(version: 20140826033700) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "cube"
  enable_extension "earthdistance"

  create_table "matches", force: true do |t|
    t.integer  "swipee_id"
    t.boolean  "likes"
    t.boolean  "match"
    t.string   "swiper_name"
    t.string   "swipee_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "profile_id"
  end

  add_index "matches", ["profile_id"], name: "index_matches_on_profile_id", using: :btree

  create_table "messages", force: true do |t|
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "match_id"
  end

  add_index "messages", ["match_id"], name: "index_messages_on_match_id", using: :btree

  create_table "profiles", force: true do |t|
    t.integer  "facebook_id",                    limit: 8
    t.integer  "age"
    t.string   "first_name"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "answer1"
    t.integer  "answer2"
    t.integer  "answer3"
    t.integer  "answer4"
    t.integer  "answer5"
    t.integer  "preferred_min_age"
    t.integer  "preferred_max_age"
    t.boolean  "prefers_male"
    t.boolean  "preferred_sound"
    t.integer  "preferred_distance"
    t.string   "image1"
    t.string   "image2"
    t.string   "image3"
    t.string   "image4"
    t.string   "image5"
    t.boolean  "male"
    t.date     "birthday"
    t.string   "access_token"
    t.string   "client_identification_sequence"
    t.string   "push_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
