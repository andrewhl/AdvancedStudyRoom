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
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'spec_helper'

describe Match do
  # let(:match) { FactoryGirl.create(:match) }


  subject(:match) { FactoryGirl.create(:match) }

  before(:each) do

    @ruleset = FactoryGirl.create(:ruleset)
    @event_ruleset = FactoryGirl.create(:event_ruleset)
    @tier_ruleset = FactoryGirl.create(:tier_ruleset)
    @division_ruleset = FactoryGirl.create(:division_ruleset)

    @division_ruleset.stub(:parent).and_return(@tier_ruleset)
    @tier_ruleset.stub(:parent).and_return(@event_ruleset)
    @event_ruleset.stub(:parent).and_return(@ruleset)
    match.stub_chain(:division, :division_ruleset).and_return(@division_ruleset)
  end

  it "should exist" do
    should be_valid
  end

  it { should respond_to :is_valid? }

  describe "validation" do

    context "komi" do

      it "should not go above max komi" do
        match.division.division_ruleset.max_komi = 6.5
        match.komi = 7.5

        match.is_valid?.should be_false
      end

      it "should not go below min komi" do
        match.division.division_ruleset.min_komi = 6.5
        match.komi = 3.5

        match.is_valid?.should be_false
      end

      it "should be valid if within komi range" do
        match.division.division_ruleset.max_komi = 5.5
        match.division.division_ruleset.min_komi = 7.5
        match.komi = 6.5

        match.is_valid?.should be_true
      end

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
