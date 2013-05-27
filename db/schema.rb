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

ActiveRecord::Schema.define(:version => 20130527224935) do

  create_table "accounts", :force => true do |t|
    t.string   "handle"
    t.integer  "user_id"
    t.integer  "server_id"
    t.integer  "rank"
    t.boolean  "active",       :default => true, :null => false
    t.float    "total_points", :default => 0.0,  :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "accounts", ["active"], :name => "index_accounts_on_active"
  add_index "accounts", ["handle"], :name => "index_accounts_on_handle"
  add_index "accounts", ["server_id"], :name => "index_accounts_on_server_id"
  add_index "accounts", ["user_id"], :name => "index_accounts_on_user_id"

  create_table "comments", :force => true do |t|
    t.integer  "match_id"
    t.text     "comment"
    t.string   "handle"
    t.string   "rank"
    t.datetime "date"
    t.integer  "node_number"
    t.integer  "line_number"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "comments", ["match_id"], :name => "index_comments_on_match_id"

  create_table "divisions", :force => true do |t|
    t.integer "tier_id"
    t.integer "index"
    t.integer "minimum_players"
    t.integer "maximum_players"
    t.string  "name"
  end

  add_index "divisions", ["index"], :name => "index_divisions_on_index"
  add_index "divisions", ["tier_id"], :name => "index_divisions_on_tier_id"

  create_table "event_tags", :force => true do |t|
    t.string   "phrase"
    t.integer  "event_id"
    t.integer  "node_limit"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "event_tags", ["event_id"], :name => "index_event_tags_on_event_id"
  add_index "event_tags", ["phrase"], :name => "index_event_tags_on_phrase"

  create_table "events", :force => true do |t|
    t.string   "name"
    t.string   "event_type"
    t.integer  "server_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "description"
  end

  add_index "events", ["server_id"], :name => "index_events_on_server_id"

  create_table "matches", :force => true do |t|
    t.string   "match_type"
    t.string   "ot_type"
    t.string   "win_info"
    t.string   "digest"
    t.string   "url"
    t.string   "filename"
    t.string   "black_player_name"
    t.string   "white_player_name"
    t.string   "tags"
    t.string   "validation_errors"
    t.boolean  "valid_match"
    t.boolean  "tagged"
    t.boolean  "has_points",        :default => false, :null => false
    t.integer  "ot_stones_periods"
    t.integer  "black_player_id"
    t.integer  "white_player_id"
    t.integer  "division_id"
    t.integer  "winner_id"
    t.integer  "loser_id"
    t.integer  "board_size"
    t.integer  "handicap"
    t.float    "komi"
    t.float    "main_time_control"
    t.float    "ot_time_control"
    t.datetime "completed_at"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  add_index "matches", ["black_player_id"], :name => "index_matches_on_black_player_id"
  add_index "matches", ["division_id"], :name => "index_matches_on_division_id"
  add_index "matches", ["loser_id"], :name => "index_matches_on_loser_id"
  add_index "matches", ["white_player_id"], :name => "index_matches_on_white_player_id"
  add_index "matches", ["winner_id"], :name => "index_matches_on_winner_id"

  create_table "permissions", :force => true do |t|
    t.string   "perm"
    t.integer  "parent_id"
    t.string   "parent_type"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "permissions", ["parent_id"], :name => "index_permissions_on_parent_id"

  create_table "point_rulesets", :force => true do |t|
    t.float    "points_per_win"
    t.float    "points_per_loss"
    t.float    "point_decay"
    t.float    "min_points_per_match"
    t.integer  "max_matches_per_opponent"
    t.integer  "pointable_id"
    t.string   "pointable_type"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "point_rulesets", ["pointable_type", "pointable_id"], :name => "index_point_rulesets_on_pointable_type_and_pointable_id"

  create_table "points", :force => true do |t|
    t.float    "count"
    t.integer  "account_id"
    t.integer  "registration_id"
    t.integer  "event_id"
    t.integer  "match_id"
    t.string   "event_desc"
    t.string   "event_type"
    t.string   "disabled_reason"
    t.boolean  "disabled",        :default => false, :null => false
    t.datetime "awarded_at"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  add_index "points", ["account_id"], :name => "index_points_on_account_id"
  add_index "points", ["event_id"], :name => "index_points_on_event_id"
  add_index "points", ["match_id"], :name => "index_points_on_match_id"
  add_index "points", ["registration_id"], :name => "index_points_on_registration_id"

  create_table "posts", :force => true do |t|
    t.text     "html"
    t.integer  "user_id"
    t.datetime "date"
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "registrations", :force => true do |t|
    t.integer  "account_id"
    t.integer  "event_id"
    t.integer  "division_id"
    t.float    "points_this_month", :default => 0.0,  :null => false
    t.float    "float",             :default => 0.0,  :null => false
    t.boolean  "active",            :default => true, :null => false
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

  add_index "registrations", ["account_id"], :name => "index_registrations_on_account_id"
  add_index "registrations", ["active"], :name => "index_registrations_on_active"
  add_index "registrations", ["division_id"], :name => "index_registrations_on_division_id"
  add_index "registrations", ["event_id"], :name => "index_registrations_on_event_id"

  create_table "rulesets", :force => true do |t|
    t.string   "name"
    t.boolean  "overtime_required"
    t.boolean  "handicap_required"
    t.boolean  "j_ot_allowed"
    t.boolean  "c_ot_allowed"
    t.float    "main_time_min"
    t.float    "main_time_max"
    t.float    "j_ot_min_period_length"
    t.float    "j_ot_max_period_length"
    t.float    "c_ot_min_time"
    t.float    "c_ot_max_time"
    t.float    "min_komi"
    t.float    "max_komi"
    t.integer  "j_ot_max_periods"
    t.integer  "j_ot_min_periods"
    t.integer  "c_ot_min_stones"
    t.integer  "c_ot_max_stones"
    t.integer  "min_handicap"
    t.integer  "max_handicap"
    t.integer  "min_board_size"
    t.integer  "max_board_size"
    t.integer  "node_limit"
    t.integer  "rulesetable_id"
    t.string   "rulesetable_type"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  create_table "servers", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "scraper_class_name"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "tiers", :force => true do |t|
    t.string   "name"
    t.integer  "index"
    t.integer  "event_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "tiers", ["event_id"], :name => "index_tiers_on_event_id"
  add_index "tiers", ["index"], :name => "index_tiers_on_index"

  create_table "users", :force => true do |t|
    t.boolean  "admin",                  :default => false, :null => false
    t.string   "email",                  :default => "",    :null => false
    t.string   "username"
    t.string   "password_digest"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

end
