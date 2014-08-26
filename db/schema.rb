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

ActiveRecord::Schema.define(version: 20140826185157) do

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
    t.string   "picture1_file_name"
    t.string   "picture1_content_type"
    t.integer  "picture1_file_size"
    t.datetime "picture1_updated_at"
    t.string   "picture2_file_name"
    t.string   "picture2_content_type"
    t.integer  "picture2_file_size"
    t.datetime "picture2_updated_at"
    t.string   "picture3_file_name"
    t.string   "picture3_content_type"
    t.integer  "picture3_file_size"
    t.datetime "picture3_updated_at"
    t.string   "picture4_file_name"
    t.string   "picture4_content_type"
    t.integer  "picture4_file_size"
    t.datetime "picture4_updated_at"
    t.string   "picture5_file_name"
    t.string   "picture5_content_type"
    t.integer  "picture5_file_size"
    t.datetime "picture5_updated_at"
    t.string   "picture1_from_url"
    t.string   "picture2_from_url"
    t.string   "picture3_from_url"
    t.string   "picture4_from_url"
    t.string   "picture5_from_url"
  end

end
