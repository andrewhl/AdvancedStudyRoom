# == Schema Information
#
# Table name: matches
#
#  id                 :integer          not null, primary key
#  datetime_completed :datetime
#  game_type          :string(255)
#  komi               :float
#  winner             :string(255)
#  win_info           :string(255)
#  main_time_control  :float
#  overtime_type      :string(255)
#  ot_stones_periods  :integer
#  ot_time_control    :float
#  url                :string(255)
#  black_player_id    :integer
#  white_player_id    :integer
#  black_player_name  :string(255)
#  white_player_name  :string(255)
#  handicap           :integer
#  game_digest        :string(255)
#  division_id        :integer
#  winner_name        :string(255)
#  winner_id          :integer
#  board_size         :integer
#  valid_game         :boolean
#  tagged             :boolean
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'spec_helper'

describe Match do
  # let(:match) { FactoryGirl.create(:match) }


  subject(:match) { FactoryGirl.create(:match) }


  let!(:ruleset) { FactoryGirl.create(:ruleset) }
  let!(:event_ruleset) { FactoryGirl.create(:event_ruleset) }
  let!(:tier_ruleset) { FactoryGirl.create(:tier_ruleset) }
  let!(:division_ruleset) { FactoryGirl.create(:division_ruleset) }

  # before(:each) do
  #   @ruleset = FactoryGirl.create(:ruleset)
  #   @event_ruleset = FactoryGirl.create(:event_ruleset)
  #   @tier_ruleset = FactoryGirl.create(:tier_ruleset)
  #   division_ruleset = FactoryGirl.create(:division_ruleset)


  # end

  it "should exist" do
    should be_valid
  end

  it { should respond_to :is_valid? }

  describe "validation failures" do

    

    # before(:each) do
    #   @ruleset = FactoryGirl.create(:ruleset)
    #   @event_ruleset = FactoryGirl.create(:event_ruleset)
    #   @tier_ruleset = FactoryGirl.create(:tier_ruleset)
    #   division_ruleset = FactoryGirl.create(:division_ruleset)
    # end

    after(:each) do
      division_ruleset.stub(:parent).and_return(tier_ruleset)
      tier_ruleset.stub(:parent).and_return(event_ruleset)
      event_ruleset.stub(:parent).and_return(ruleset)
      match.stub_chain(:division, :division_ruleset).and_return(division_ruleset)
      match.is_valid?.should be_false
    end

    context "komi" do

      it "should not go above max komi" do
        division_ruleset = FactoryGirl.create(:empty_division_ruleset, max_komi: 6.5)
        match.komi = 7.5
      end

      it "should not go below min komi" do
        division_ruleset = FactoryGirl.create(:empty_division_ruleset, min_komi: 6.5)
        # division_ruleset.min_komi = 6.5
        # division_ruleset.save
        match.komi = 3.5

      end

      # it "should be valid if within komi range" do
      #   division_ruleset.max_komi = 5.5
      #   division_ruleset.min_komi = 7.5
      #   division_ruleset.save
      #   match.komi = 6.5

      #   match.is_valid?.should be_true
      # end

    end



    context "main time" do

      it "should not be less than the main time minimum" do
        division_ruleset = FactoryGirl.create(:empty_division_ruleset, main_time_min: 2700.0)
        # division_ruleset.main_time_min = 2700.0
        match.main_time_control = 2500.0
      end

      it "should not be greater than the main time maximum" do
        division_ruleset = FactoryGirl.create(:empty_division_ruleset, main_time_max: 2700.0)
        # division_ruleset.main_time_max = 2700.0
        match.main_time_control = 2900.0
      end

    end



    context "overtime" do

      it "should obey overtime boolean" do
        division_ruleset = FactoryGirl.create(:empty_division_ruleset, overtime_required: true)
        # division_ruleset.overtime_required = true
        match.overtime_type = nil
      end

      it "should obey japanese overtime boolean" do
        division_ruleset = FactoryGirl.create(:empty_division_ruleset, jovertime_allowed: false)
        # division_ruleset.jovertime_allowed = false
        match.overtime_type = "byo-yomi"
      end

      it "should obey canadian overtime boolean" do
        division_ruleset = FactoryGirl.create(:empty_division_ruleset, covertime_allowed: false)
        # division_ruleset.covertime_allowed = false
        match.overtime_type = "Canadian"
      end

      it "should not have too many byo-yomi periods" do
        division_ruleset = FactoryGirl.create(:empty_division_ruleset, jot_max_periods: 5, jovertime_allowed: true)
        # division_ruleset.jot_max_periods = 5
        # division_ruleset.jovertime_allowed = true
        match.overtime_type = "byo_yomi"
        match.ot_stones_periods = 10
      end

      it "should not have too few byo_yomi periods" do
        division_ruleset = FactoryGirl.create(:empty_division_ruleset, jot_min_periods: 10, jovertime_allowed: true)
        match.overtime_type = "byo_yomi"
        match.ot_stones_periods = 5
      end

      it "should not exceed the jot max period length" do
        division_ruleset = FactoryGirl.create(:empty_division_ruleset, jot_max_period_length: 60, jovertime_allowed: true)
        # division_ruleset.jot_max_period_length = 60
        # division_ruleset.jovertime_allowed = true
        match.overtime_type = "byo_yomi"
        match.ot_time_control = 90
      end

      it "should not go below the jot min period length" do
        division_ruleset = FactoryGirl.create(:empty_division_ruleset, jot_min_period_length: 60, jovertime_allowed: true)
        # division_ruleset.jot_min_period_length = 60
        # division_ruleset.jovertime_allowed = true
        match.overtime_type = "byo_yomi"
        match.ot_time_control = 30
      end

      it "should not have too many canadian stones" do
        division_ruleset = FactoryGirl.create(:empty_division_ruleset, cot_max_stones: 25, covertime_allowed: true)
        # division_ruleset.cot_max_stones = 25
        # division_ruleset.covertime_allowed = true
        match.overtime_type = "Canadian"
        match.ot_stones_periods = 50
      end

      it "should not have too few canadian stones" do
        division_ruleset = FactoryGirl.create(:empty_division_ruleset, cot_min_stones: 25, covertime_allowed: true)
        # division_ruleset.cot_min_stones = 25
        # division_ruleset.covertime_allowed = true
        match.overtime_type = "Canadian"
        match.ot_stones_periods = 10
      end

      it "should not exceed the max canadian time" do
        division_ruleset = FactoryGirl.create(:empty_division_ruleset, cot_max_time: 300, covertime_allowed: true)
        # division_ruleset.cot_max_time = 300
        # division_ruleset.covertime_allowed = true
        match.overtime_type = "Canadian"
        match.ot_time_control = 400
      end

      it "should not go below the min canadian time" do
        division_ruleset = FactoryGirl.create(:empty_division_ruleset, cot_min_time: 300, covertime_allowed: true)
        # division_ruleset.cot_min_time = 300
        # division_ruleset.covertime_allowed = true
        match.overtime_type = "Canadian"
        match.ot_time_control = 150
      end
    end



    context "handicap" do

      it "should not exceed max handicap" do
        division_ruleset = FactoryGirl.create(:empty_division_ruleset, max_handi: 5)
        division_ruleset.max_handi = 5
        match.handicap = 9
      end

      it "should not be less than min handicap" do
        division_ruleset = FactoryGirl.create(:empty_division_ruleset, min_handi: 2)
        division_ruleset.min_handi = 2
        match.handicap = 0
      end

      it "should have a handicap if handicap is required" do
        division_ruleset = FactoryGirl.create(:empty_division_ruleset, handicap_required: true)
        division_ruleset.handicap_required = true
        match.handicap = 0
      end
    end

    context "games" do

      it "should not exceed the number of allowed games per player" do
        division_ruleset = FactoryGirl.create(:empty_division_ruleset, handicap_required: true)
        @second_match = FactoryGirl.create(:second_match)

        # match_two = FactoryGirl.create(:second_match)
        # division_ruleset.games_per_opponent = 1
        # division_ruleset.save
        # match.stub_chain(:similar_games, :count).and_return(2)
      end
    end
  end

  describe "validation successes" do

    before(:each) do
      @ruleset = FactoryGirl.create(:ruleset)
      @event_ruleset = FactoryGirl.create(:event_ruleset)
      @tier_ruleset = FactoryGirl.create(:tier_ruleset)
      division_ruleset = FactoryGirl.create(:division_ruleset)

      division_ruleset.stub(:parent).and_return(@tier_ruleset)
      @tier_ruleset.stub(:parent).and_return(@event_ruleset)
      @event_ruleset.stub(:parent).and_return(@ruleset)
      match.stub_chain(:division, :division_ruleset).and_return(division_ruleset)

    end

    after(:each) do
      match.is_valid?.should be_true
    end

    context "komi" do

      it "should be valid if komi is correct" do
        match.komi = 5.5
      end

    end

  end

  describe "without canonical ruleset" do

    before(:each) do
      @event_ruleset = FactoryGirl.create(:event_ruleset)
      @tier_ruleset = FactoryGirl.create(:tier_ruleset)
      division_ruleset = FactoryGirl.create(:empty_division_ruleset)

      division_ruleset.stub(:parent).and_return(@tier_ruleset)
      @tier_ruleset.stub(:parent).and_return(@event_ruleset)
      @event_ruleset.stub(:parent).and_return(nil)
      match.stub_chain(:division, :division_ruleset).and_return(division_ruleset)

    end

    it "should be valid" do
      match.is_valid?.should be_true
    end
  end



end



    # datetime_completed "2012-10-09 00:00:00"
    # komi 6.5
    # winner "W"
    # win_info "Resign"
    # main_time_control 2400.0
    # overtime_type "byo-yomi"
    # ot_stones_periods 30
    # ot_time_control 5.0
    # black_player_id 18
    # white_player_id 11
    # black_player_name "twisted"
    # white_player_name "kabradarf"
    # handicap nil
    # game_digest "5fed482a6963e7efce38986906b687fb"
