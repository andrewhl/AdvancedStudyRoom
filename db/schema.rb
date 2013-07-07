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

ActiveRecord::Schema.define(:version => 20130707001119) do

  create_table "accounts", :force => true do |t|
    t.string   "handle"
    t.integer  "user_id"
    t.integer  "server_id"
    t.integer  "rank"
    t.boolean  "private",    :default => false, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "accounts", ["server_id"], :name => "index_accounts_on_server_id"
  add_index "accounts", ["user_id"], :name => "index_accounts_on_user_id"

  create_table "event_periods", :force => true do |t|
    t.integer  "event_id"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "opens_at"
    t.datetime "closes_at"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "event_periods", ["event_id"], :name => "index_event_periods_on_event_id"

  create_table "event_tags", :force => true do |t|
    t.string   "phrase",     :limit => 100
    t.integer  "event_id",                  :null => false
    t.integer  "node_limit"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "event_tags", ["event_id"], :name => "index_event_tags_on_event_id"
  add_index "event_tags", ["phrase"], :name => "index_event_tags_on_phrase"

  create_table "event_types", :force => true do |t|
    t.string   "name",        :limit => 100
    t.string   "description"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "events", :force => true do |t|
    t.string   "name",               :limit => 100
    t.text     "description"
    t.text     "prizes_description"
    t.integer  "event_type_id"
    t.integer  "server_id"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "opens_at"
    t.datetime "closes_at"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "events", ["server_id"], :name => "index_events_on_server_id"

  create_table "match_comments", :force => true do |t|
    t.integer  "match_id"
    t.text     "comment"
    t.string   "handle",      :limit => 100
    t.string   "rank",        :limit => 5
    t.datetime "date"
    t.integer  "node_number"
    t.integer  "line_number"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "match_comments", ["match_id"], :name => "index_match_comments_on_match_id"

  create_table "match_details", :force => true do |t|
    t.integer  "match_id"
    t.integer  "ot_stones_periods"
    t.integer  "board_size"
    t.integer  "handicap"
    t.string   "type",              :limit => 100
    t.string   "ot_type",           :limit => 100
    t.string   "win_info",          :limit => 100
    t.string   "filename"
    t.string   "black_player_name", :limit => 100
    t.string   "white_player_name", :limit => 100
    t.float    "komi"
    t.float    "main_time_control"
    t.float    "ot_time_control"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "match_details", ["match_id"], :name => "index_match_details_on_match_id"

  create_table "match_registrations", :force => true do |t|
    t.integer  "match_id"
    t.integer  "registration_id"
    t.boolean  "white"
    t.boolean  "black"
    t.boolean  "winner"
    t.boolean  "loser"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "match_registrations", ["loser"], :name => "index_match_registrations_on_loser"
  add_index "match_registrations", ["match_id"], :name => "index_match_registrations_on_match_id"
  add_index "match_registrations", ["winner"], :name => "index_match_registrations_on_winner"

  create_table "match_tags", :force => true do |t|
    t.integer  "match_id"
    t.integer  "comment_id"
    t.integer  "node"
    t.string   "phrase",     :limit => 100
    t.string   "handle",     :limit => 100
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "match_tags", ["handle"], :name => "index_match_tags_on_handle"
  add_index "match_tags", ["match_id"], :name => "index_match_tags_on_match_id"

  create_table "matches", :force => true do |t|
    t.integer  "registration_group_id"
    t.string   "digest"
    t.string   "url"
    t.string   "validation_errors"
    t.boolean  "valid_match"
    t.boolean  "tagged"
    t.boolean  "has_points",            :default => false, :null => false
    t.datetime "completed_at"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  add_index "matches", ["registration_group_id"], :name => "index_matches_on_registration_group_id"

  create_table "pages", :force => true do |t|
    t.integer  "user_id"
    t.integer  "sort_order", :default => 0, :null => false
    t.datetime "date"
    t.text     "body"
    t.string   "title"
    t.string   "permalink"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "point_rulesets", :force => true do |t|
    t.float    "points_per_win"
    t.float    "points_per_loss"
    t.float    "win_decay"
    t.float    "loss_decay"
    t.float    "min_points_per_match"
    t.integer  "max_matches_per_opponent"
    t.integer  "point_rulesetable_id"
    t.string   "point_rulesetable_type"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "point_rulesets", ["point_rulesetable_type", "point_rulesetable_id"], :name => "point_rulesets_on_point_rulesetable"

  create_table "points", :force => true do |t|
    t.integer  "account_id"
    t.float    "count"
    t.text     "description"
    t.string   "disabled_reason"
    t.boolean  "disabled",        :default => false, :null => false
    t.datetime "disabled_at"
    t.datetime "awarded_at"
    t.integer  "pointable_id"
    t.string   "pointable_type"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  add_index "points", ["account_id"], :name => "index_points_on_account_id"

  create_table "posts", :force => true do |t|
    t.integer  "user_id"
    t.text     "body"
    t.datetime "date"
    t.string   "title"
    t.string   "permalink"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "registration_group_types", :force => true do |t|
    t.string   "name",        :limit => 100
    t.string   "description"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "registration_groups", :force => true do |t|
    t.integer  "event_period_id"
    t.integer  "parent_id"
    t.integer  "registration_group_type_id"
    t.string   "name",                       :limit => 100
    t.integer  "min_registrations"
    t.integer  "max_registrations"
    t.integer  "position",                                  :default => 1, :null => false
    t.datetime "created_at",                                               :null => false
    t.datetime "updated_at",                                               :null => false
  end

  add_index "registration_groups", ["event_period_id"], :name => "index_registration_groups_on_event_period_id"
  add_index "registration_groups", ["parent_id"], :name => "index_registration_groups_on_parent_id"

  create_table "registrations", :force => true do |t|
    t.integer  "account_id"
    t.integer  "event_period_id"
    t.integer  "registration_group_id"
    t.float    "total_points",          :default => 0.0,  :null => false
    t.float    "float",                 :default => 0.0,  :null => false
    t.boolean  "active",                :default => true, :null => false
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
  end

  add_index "registrations", ["account_id"], :name => "index_registrations_on_account_id"
  add_index "registrations", ["active"], :name => "index_registrations_on_active"
  add_index "registrations", ["event_period_id"], :name => "index_registrations_on_event_period_id"
  add_index "registrations", ["registration_group_id"], :name => "index_registrations_on_registration_group_id"

  create_table "rulesets", :force => true do |t|
    t.string   "name",                   :limit => 100
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
    t.integer  "j_ot_min_periods"
    t.integer  "j_ot_max_periods"
    t.integer  "c_ot_min_stones"
    t.integer  "c_ot_max_stones"
    t.integer  "min_handicap"
    t.integer  "max_handicap"
    t.integer  "min_board_size"
    t.integer  "max_board_size"
    t.integer  "node_limit"
    t.integer  "rulesetable_id"
    t.string   "rulesetable_type"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

  create_table "servers", :force => true do |t|
    t.string   "name",               :limit => 100
    t.string   "url"
    t.string   "scraper_class_name", :limit => 100
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "users", :force => true do |t|
    t.boolean  "admin",                  :default => false, :null => false
    t.string   "email",                  :default => "",    :null => false
    t.string   "username"
    t.string   "password_digest"
    t.string   "first_name"
    t.string   "last_name"
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
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

end
