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

ActiveRecord::Schema.define(:version => 20121202075334) do

  create_table "accounts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "server_id"
    t.integer  "event_id"
    t.string   "handle"
    t.integer  "league_tier"
    t.integer  "league_active"
    t.integer  "rank"
    t.integer  "status"
    t.integer  "division_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "accounts", ["division_id"], :name => "index_accounts_on_division_id"
  add_index "accounts", ["event_id"], :name => "index_accounts_on_event_id"
  add_index "accounts", ["handle"], :name => "index_accounts_on_handle"
  add_index "accounts", ["server_id"], :name => "index_accounts_on_server_id"
  add_index "accounts", ["user_id"], :name => "index_accounts_on_user_id"

  create_table "achievements", :force => true do |t|
    t.string   "achievement_name"
    t.string   "earned_image_url"
    t.string   "pending_image_url"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "awards", :force => true do |t|
    t.integer  "user_id"
    t.integer  "achievement_id"
    t.datetime "date_awarded"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "awards", ["achievement_id"], :name => "index_awards_on_achievement_id"
  add_index "awards", ["user_id"], :name => "index_awards_on_user_id"

  create_table "comments", :force => true do |t|
    t.integer  "match_id"
    t.integer  "node"
    t.string   "comment"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "comments", ["match_id"], :name => "index_comments_on_match_id"

  create_table "division_players", :force => true do |t|
    t.integer  "division_id"
    t.integer  "account_id"
    t.float    "points"
    t.integer  "status"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "division_players", ["account_id"], :name => "index_division_players_on_account_id"
  add_index "division_players", ["division_id"], :name => "index_division_players_on_division_id"

  create_table "division_rules", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "divisions", :force => true do |t|
    t.integer  "tier_id"
    t.datetime "month"
    t.integer  "division_index"
    t.integer  "minimum_players"
    t.integer  "maximum_players"
    t.integer  "current_players"
    t.integer  "safe_position"
    t.integer  "promoted_players"
    t.integer  "demoted_players"
    t.string   "name"
    t.string   "custom_name"
    t.boolean  "use_custom_name"
  end

  add_index "divisions", ["division_index"], :name => "index_divisions_on_division_index"
  add_index "divisions", ["tier_id"], :name => "index_divisions_on_tier_id"

  create_table "events", :force => true do |t|
    t.integer  "ruleset_id"
    t.string   "name"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "ruleset_name"
    t.string   "event_type"
    t.integer  "ruleset_default"
    t.integer  "league_id"
    t.integer  "server_id"
    t.boolean  "locked"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "events", ["league_id"], :name => "index_events_on_league_id"
  add_index "events", ["ruleset_id"], :name => "index_events_on_ruleset_id"
  add_index "events", ["server_id"], :name => "index_events_on_server_id"

  create_table "matches", :force => true do |t|
    t.datetime "datetime_completed"
    t.string   "game_type"
    t.float    "komi"
    t.string   "winner"
    t.string   "win_info"
    t.float    "main_time_control"
    t.string   "overtime_type"
    t.integer  "ot_stones_periods"
    t.float    "ot_time_control"
    t.string   "url"
    t.integer  "black_player_id"
    t.integer  "white_player_id"
    t.string   "black_player_name"
    t.string   "white_player_name"
    t.integer  "handicap"
    t.string   "game_digest"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "matches", ["black_player_id"], :name => "index_matches_on_black_player_id"
  add_index "matches", ["white_player_id"], :name => "index_matches_on_white_player_id"

  create_table "points", :force => true do |t|
    t.integer  "count"
    t.integer  "account_id"
    t.integer  "event_id"
    t.string   "event_desc"
    t.string   "event_type"
    t.string   "game_hash"
    t.integer  "registration_id"
    t.boolean  "enabled"
    t.integer  "match_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "points", ["account_id"], :name => "index_points_on_account_id"
  add_index "points", ["event_id"], :name => "index_points_on_event_id"
  add_index "points", ["event_type"], :name => "index_points_on_event_type"
  add_index "points", ["game_hash"], :name => "index_points_on_game_hash"
  add_index "points", ["match_id"], :name => "index_points_on_match_id"

  create_table "registrations", :force => true do |t|
    t.integer  "account_id"
    t.integer  "event_id"
    t.integer  "division_id"
    t.string   "handle"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "registrations", ["account_id"], :name => "index_registrations_on_account_id"
  add_index "registrations", ["division_id"], :name => "index_registrations_on_division_id"
  add_index "registrations", ["event_id"], :name => "index_registrations_on_event_id"

  create_table "rulesets", :force => true do |t|
    t.string   "name"
    t.boolean  "allowed_rengo"
    t.boolean  "allowed_teaching"
    t.boolean  "allowed_review"
    t.boolean  "allowed_free"
    t.boolean  "allowed_rated"
    t.boolean  "allowed_simul"
    t.boolean  "allowed_demonstration"
    t.float    "main_time_min"
    t.float    "main_time_max"
    t.boolean  "overtime_required"
    t.boolean  "jovertime_allowed"
    t.boolean  "covertime_allowed"
    t.integer  "jot_min_periods"
    t.integer  "jot_max_periods"
    t.float    "jot_min_period_length"
    t.float    "jot_max_period_length"
    t.integer  "cot_min_stones"
    t.integer  "cot_max_stones"
    t.float    "cot_max_time"
    t.float    "cot_min_time"
    t.float    "handicap_default"
    t.integer  "ruleset_default"
    t.integer  "games_per_player"
    t.integer  "games_per_opponent"
    t.boolean  "canonical"
    t.string   "type"
    t.integer  "division_id"
    t.integer  "tier_id"
    t.integer  "event_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "rulesets", ["division_id"], :name => "index_rulesets_on_division_id"
  add_index "rulesets", ["event_id"], :name => "index_rulesets_on_event_id"
  add_index "rulesets", ["tier_id"], :name => "index_rulesets_on_tier_id"

  create_table "servers", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tags", :force => true do |t|
    t.string   "phrase"
    t.integer  "league_id"
    t.integer  "event_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "tags", ["event_id"], :name => "index_tags_on_event_id"
  add_index "tags", ["league_id"], :name => "index_tags_on_league_id"

  create_table "tier_types", :force => true do |t|
    t.string   "name"
    t.integer  "default_promotions"
    t.integer  "default_demotions"
    t.integer  "tier_hierarchy_position"
    t.integer  "default_divisions"
    t.integer  "max_games_per_player"
    t.integer  "max_games_per_opponent"
    t.float    "points_per_win"
    t.float    "points_per_loss"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  create_table "tiers", :force => true do |t|
    t.integer  "tier_type_id"
    t.integer  "promotions"
    t.integer  "demotions"
    t.integer  "tier_hierarchy_position"
    t.integer  "divisions"
    t.integer  "max_games_per_player"
    t.integer  "max_games_per_opponent"
    t.float    "points_per_win"
    t.float    "points_per_loss"
    t.integer  "event_id"
    t.integer  "league_id"
    t.string   "name"
    t.integer  "parent_id"
    t.integer  "child_id"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "tiers", ["child_id"], :name => "index_tiers_on_child_id"
  add_index "tiers", ["event_id"], :name => "index_tiers_on_event_id"
  add_index "tiers", ["league_id"], :name => "index_tiers_on_league_id"
  add_index "tiers", ["parent_id"], :name => "index_tiers_on_parent_id"
  add_index "tiers", ["tier_type_id"], :name => "index_tiers_on_tier_type_id"

  create_table "tournaments", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "username"
    t.integer  "access_level"
    t.boolean  "password_reset_flag"
    t.datetime "last_signed_in"
    t.datetime "last_scraped"
    t.float    "points"
    t.float    "month_points"
    t.float    "lifetime_points"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "password_digest"
    t.boolean  "admin"
    t.integer  "rank"
    t.integer  "kgs_rank"
    t.integer  "kaya_rank"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

end
