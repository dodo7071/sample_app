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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130617090947) do

  create_table "activities", :force => true do |t|
    t.integer  "user_id"
    t.integer  "activity_type_id"
    t.date     "beg_date"
    t.date     "end_date"
    t.time     "beg_time"
    t.time     "end_time"
    t.string   "note"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "location_id"
    t.string   "title"
  end

  add_index "activities", ["location_id"], :name => "location_id_index"
  add_index "activities", ["user_id", "created_at"], :name => "index_activities_on_user_id_and_created_at"

  create_table "activity_comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "activity_id"
    t.string   "text"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "activity_comments", ["activity_id"], :name => "activity_idx"

  create_table "activity_facilities", :force => true do |t|
    t.integer  "activity_id"
    t.integer  "facility_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "activity_facilities", ["facility_id"], :name => "facility_id_idx"

  create_table "activity_type_facilities", :force => true do |t|
    t.integer "activity_type_id"
    t.integer "facility_id"
  end

  add_index "activity_type_facilities", ["activity_type_id"], :name => "activity_type_id_index"
  add_index "activity_type_facilities", ["facility_id"], :name => "facility_id_index"

  create_table "activity_types", :force => true do |t|
    t.string "name"
  end

  add_index "activity_types", ["id"], :name => "activity_id_idx"

  create_table "evaluations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "facility_id"
    t.integer  "value"
    t.string   "note"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "evaluations", ["facility_id"], :name => "facility_idx"

  create_table "facilities", :force => true do |t|
    t.integer "location_id"
    t.string  "title"
    t.string  "info",        :limit => 2500
    t.string  "services",    :limit => 1000
    t.string  "adress"
    t.string  "web_page"
    t.string  "email"
    t.string  "gps"
    t.string  "telephone"
  end

  add_index "facilities", ["id"], :name => "id_idx"
  add_index "facilities", ["location_id"], :name => "location_idx"

  create_table "followings", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "followings", ["followed_id"], :name => "followed_id_idx"
  add_index "followings", ["follower_id"], :name => "follower_id_idx"

  create_table "locations", :force => true do |t|
    t.string  "name"
    t.integer "region_id"
  end

  add_index "locations", ["id"], :name => "location_id_idx"

  create_table "participations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "activity_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "participations", ["activity_id"], :name => "activity__idx"
  add_index "participations", ["user_id"], :name => "user_id_index"

  create_table "post_comments", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "posts", :force => true do |t|
    t.string   "content",    :limit => 1000
    t.integer  "user_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.integer  "target_id"
  end

  create_table "regions", :force => true do |t|
    t.string "name"
    t.string "country_id"
  end

  create_table "user_activities", :force => true do |t|
    t.integer  "user_id"
    t.integer  "activity_type_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "user_activities", ["activity_type_id"], :name => "activity_type_id_idx"
  add_index "user_activities", ["user_id"], :name => "user_id_idx"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin"
    t.date     "birth_date"
    t.string   "contact"
    t.integer  "location_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["id"], :name => "id_index"
  add_index "users", ["location_id"], :name => "location_index"
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

  add_foreign_key "activities", "activity_types", :name => "activities_activity_type_id_fk"
  add_foreign_key "activities", "locations", :name => "activities_location_id_fk"
  add_foreign_key "activities", "users", :name => "activities_user_id_fk"

  add_foreign_key "activity_comments", "activities", :name => "activity_comments_activity_id_fk"
  add_foreign_key "activity_comments", "users", :name => "activity_comments_user_id_fk"

  add_foreign_key "activity_facilities", "activities", :name => "activity_facilities_activity_id_fk"
  add_foreign_key "activity_facilities", "facilities", :name => "activity_facilities_facility_id_fk"

  add_foreign_key "activity_type_facilities", "activity_types", :name => "activity_type_facilities_activity_type_id_fk"
  add_foreign_key "activity_type_facilities", "facilities", :name => "activity_type_facilities_facility_id_fk"

  add_foreign_key "evaluations", "facilities", :name => "evaluations_facility_id_fk"
  add_foreign_key "evaluations", "users", :name => "evaluations_user_id_fk"

  add_foreign_key "facilities", "locations", :name => "facilities_location_id_fk"

  add_foreign_key "locations", "regions", :name => "locations_region_id_fk"

  add_foreign_key "participations", "activities", :name => "participations_activity_id_fk"
  add_foreign_key "participations", "users", :name => "participations_user_id_fk"

  add_foreign_key "user_activities", "activity_types", :name => "user_activities_activity_type_id_fk"
  add_foreign_key "user_activities", "users", :name => "user_activities_user_id_fk"

end
