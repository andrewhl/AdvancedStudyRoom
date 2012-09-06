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

ActiveRecord::Schema.define(:version => 20120721205104) do

  create_table "bracket_rules", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "brackets", :force => true do |t|
    t.integer  "division_id"
    t.integer  "min_players"
    t.integer  "max_players"
    t.integer  "division_pos"
    t.float    "min_points_required"
    t.integer  "min_position_required"
    t.integer  "min_games_required"
    t.integer  "min_wins_required"
    t.integer  "max_losses_required"
    t.boolean  "immunity_boolean"
    t.integer  "demotion_buffer"
    t.integer  "promotion_buffer"
    t.string   "name"
    t.string   "suffix"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "division_rules", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "divisions", :force => true do |t|
    t.string  "division_name"
    t.string  "bracket_suffix"
    t.integer "bracket_players_min"
    t.integer "bracket_players_max"
    t.integer "bracket_number"
    t.integer "division_players_min"
    t.integer "division_players_max"
    t.float   "min_points_required"
    t.integer "min_position_required"
    t.integer "min_games_required"
    t.integer "min_wins_required"
    t.integer "max_losses_required"
    t.boolean "immunity_boolean"
    t.integer "demotion_buffer"
    t.integer "promotion_buffer"
    t.integer "rules_id"
    t.integer "division_hierarchy"
  end

  create_table "matches", :force => true do |t|
    t.string   "url"
    t.string   "white_player_name"
    t.integer  "white_player_rank"
    t.string   "black_player_name"
    t.integer  "black_player_rank"
    t.boolean  "result_boolean"
    t.float    "score"
    t.integer  "board_size"
    t.integer  "handi"
    t.integer  "unixtime"
    t.string   "game_type"
    t.float    "komi"
    t.string   "result"
    t.integer  "main_time"
    t.string   "invalid_reason"
    t.string   "ruleset"
    t.integer  "overtime_periods"
    t.integer  "overtime_seconds"
    t.string   "time_system"
    t.string   "black_player_name_2"
    t.string   "white_player_name_2"
    t.integer  "black_player_rank_2"
    t.integer  "white_player_rank_2"
    t.boolean  "valid_game"
    t.integer  "user_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "rules", :force => true do |t|
    t.boolean  "rengo"
    t.boolean  "teaching"
    t.boolean  "review"
    t.boolean  "free"
    t.boolean  "rated"
    t.boolean  "demonstration"
    t.boolean  "unfinished"
    t.integer  "tag_pos"
    t.string   "tag_phrase"
    t.boolean  "tag_boolean"
    t.boolean  "ot_boolean"
    t.integer  "byo_yomi_periods"
    t.integer  "byo_yomi_seconds"
    t.string   "ruleset"
    t.boolean  "ruleset_boolean"
    t.float    "komi"
    t.boolean  "komi_boolean"
    t.string   "handicap"
    t.boolean  "handicap_boolean"
    t.integer  "max_games"
    t.float    "points_per_win"
    t.float    "points_per_loss"
    t.integer  "main_time"
    t.boolean  "main_time_boolean"
    t.string   "month"
    t.integer  "canadian_stones"
    t.integer  "canadian_time"
    t.integer  "number_of_divisions"
    t.string   "time_system"
    t.boolean  "division_boolean"
    t.string   "board_size"
    t.boolean  "board_size_boolean"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "tournaments", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
