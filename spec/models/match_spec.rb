require 'spec_helper'

describe Match do
  # let(:match) { FactoryGirl.create(:match) }


  subject(:match) { FactoryGirl.create(:match) }

  before(:each) do

    @ruleset = FactoryGirl.create(:ruleset)
    @event_ruleset = FactoryGirl.create(:event_ruleset)
    @tier_ruleset = FactoryGirl.create(:tier_ruleset)
    @division_ruleset = FactoryGirl.create(:division_ruleset)

    @division_ruleset.stub(:tier_ruleset).and_return(@tier_ruleset)
    @tier_ruleset.stub(:event_ruleset).and_return(@event_ruleset)
    @event_ruleset.stub(:ruleset).and_return(@ruleset)
    match.stub_chain(:division, :division_ruleset).and_return(@division_ruleset)
  end

  it "should exist" do
    should be_valid
  end

  it { should respond_to :is_valid? }

  describe "validation" do

    context "komi" do

      it "should not exceed ruleset komi" do
        match.division.division_ruleset.stub(:max_komi) { 6.5 }
        match.division.division_ruleset.stub(:min_komi) { 6.5 }
        match.komi = 7.5

        match.is_valid?.should be_false
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