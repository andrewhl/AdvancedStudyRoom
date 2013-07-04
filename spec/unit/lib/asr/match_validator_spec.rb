require 'spec_helper'

describe ASR::MatchValidator do

  let(:match) { FactoryGirl.build(:match) }
  let(:match_detail) { match.match_detail }

  subject(:rule_checker) do
    rules = FactoryGirl.build(:ruleset).rules
    ASR::MatchValidator.new(rules)
  end

  describe "general rule validations" do
    it "should pass if match is valid" do
      rule_checker.valid?(match).should be_true
    end
  end

  describe "specific rule validations" do

    context "main time" do
      it "should be greater than the minimum main time" do
        match_detail.main_time_control = 2800.0
        rule_checker.send(:main_time_min, 2700.0, match).should be_true
      end

      it "should be less than the maximum main time" do
        match_detail.main_time_control = 2600.0
        rule_checker.send(:main_time_max, 2700.0, match).should be_true
      end
    end


    context "overtime" do
      it "should check that ot_type is present of overtime is required" do
        match_detail.ot_type = nil
        rule_checker.send(:overtime_required, true, match).should be_false
      end

      it "should check that ot_stones_periods is present if overtime is required" do
        match_detail.ot_type = Match::BYO_YOMI
        match_detail.ot_stones_periods = nil
        rule_checker.send(:overtime_required, true, match).should be_false
      end

      it "should check that ot_time_control is present of overtime is required" do
        match_detail.ot_type = Match::BYO_YOMI
        match_detail.ot_stones_periods = 5
        match_detail.ot_time_control = nil
        rule_checker.send(:overtime_required, true, match).should be_false
      end

      it "should validate match with all defined overtime settings and overtime required" do
        match_detail.ot_stones_periods = 5
        match_detail.ot_type = Match::BYO_YOMI
        match_detail.ot_time_control = 10
        rule_checker.send(:overtime_required, true, match).should be_true
      end

      it "should check that overtime type is Canadian" do
        match_detail.ot_type = Match::CANADIAN
        rule_checker.send(:c_ot_allowed, true, match).should be_true
      end

      it "should fail if overtime type is Canadian but not allowed" do
        match_detail.ot_type = Match::CANADIAN
        rule_checker.send(:c_ot_allowed, false, match).should be_false
      end

     it "should check that overtime type is byo-yomi" do
        match_detail.ot_type = Match::BYO_YOMI
        rule_checker.send(:j_ot_allowed, true, match).should be_true
      end

      it "should fail if overtime type is byo-yomi but not allowed" do
        match_detail.ot_type = Match::BYO_YOMI
        rule_checker.send(:j_ot_allowed, false, match).should be_false
      end

      it "should have fewer or equal to max japanese periods" do
        match_detail.ot_type = Match::BYO_YOMI
        match_detail.ot_time_control = 4
        rule_checker.send(:j_ot_max_periods, 5, match).should be_true
        match_detail.ot_time_control = 5
        rule_checker.send(:j_ot_max_periods, 5, match).should be_true
      end

      it "should fail if greater than max japanese periods" do
        match_detail.ot_type = Match::BYO_YOMI
        match_detail.ot_time_control = 6
        rule_checker.send(:j_ot_max_periods, 5, match).should be_false
      end

      it "should have greater or equal to min japanese periods" do
        match_detail.ot_type = Match::BYO_YOMI
        match_detail.ot_time_control = 5
        rule_checker.send(:j_ot_min_periods, 5, match).should be_true
        match_detail.ot_time_control = 6
        rule_checker.send(:j_ot_min_periods, 5, match).should be_true
      end

      it "should fail if less than min japanese periods" do
        match_detail.ot_type = Match::BYO_YOMI
        match_detail.ot_time_control = 4
        rule_checker.send(:j_ot_min_periods, 5, match).should be_false
      end

      it "should fail if less than min japanese period length" do
        match_detail.ot_type = Match::BYO_YOMI
        match_detail.ot_stones_periods = 4
        rule_checker.send(:j_ot_min_period_length, 5, match).should be_false
      end

      it "should pass if greater than or equal to min japanese period length" do
        match_detail.ot_type = Match::CANADIAN
        match_detail.ot_stones_periods = 10
        rule_checker.send(:j_ot_min_period_length, 10, match).should be_true
        match_detail.ot_stones_periods = 15
        rule_checker.send(:j_ot_min_period_length, 10, match).should be_true
      end

      it "should fail if greater than max japanese period length" do
        match_detail.ot_type = Match::BYO_YOMI
        match_detail.ot_stones_periods = 15
        rule_checker.send(:j_ot_max_period_length, 10, match).should be_false
      end

      it "should pass if less than or equal to max japanese period length" do
        match_detail.ot_type = Match::CANADIAN
        match_detail.ot_stones_periods = 10
        rule_checker.send(:j_ot_max_period_length, 10, match).should be_true
        match_detail.ot_stones_periods = 5
        rule_checker.send(:j_ot_max_period_length, 10, match).should be_true
      end

      it "should pass if less than or equal to max Canadian stones" do
        match_detail.ot_type = Match::CANADIAN
        match_detail.ot_stones_periods = 26
        rule_checker.send(:c_ot_max_stones, 26, match).should be_true
        match_detail.ot_stones_periods = 25
        rule_checker.send(:c_ot_max_stones, 26, match).should be_true
      end

      it "should fail if greater than max Canadian stones" do
        match_detail.ot_type = Match::CANADIAN
        match_detail.ot_stones_periods = 25
        rule_checker.send(:c_ot_max_stones, 24, match).should be_false
      end

      it "should pass if greater than or equal to min Canadian stones" do
        match_detail.ot_type = Match::CANADIAN
        match_detail.ot_stones_periods = 26
        rule_checker.send(:c_ot_min_stones, 26, match).should be_true
        match_detail.ot_stones_periods = 27
        rule_checker.send(:c_ot_min_stones, 26, match).should be_true
      end

      it "should fail if less than min Canadian stones" do
        match_detail.ot_type = Match::CANADIAN
        match_detail.ot_stones_periods = 23
        rule_checker.send(:c_ot_min_stones, 24, match).should be_false
      end

      it "should fail if greater than max Canadian time" do
        match_detail.ot_type = Match::CANADIAN
        match_detail.ot_time_control = 60
        rule_checker.send(:c_ot_max_time, 30, match).should be_false
      end

      it "should pass if less than or equal to max Canadian time" do
        match_detail.ot_type = Match::CANADIAN
        match_detail.ot_time_control = 60
        rule_checker.send(:c_ot_max_time, 60, match).should be_true
        match_detail.ot_time_control = 30
        rule_checker.send(:c_ot_max_time, 60, match).should be_true
      end

      it "should fail if less than min Canadian time" do
        match_detail.ot_type = Match::CANADIAN
        match_detail.ot_time_control = 30
        rule_checker.send(:c_ot_min_time, 60, match).should be_false
      end

      it "should pass if greater than or equal to min Canadian time" do
        match_detail.ot_type = Match::CANADIAN
        match_detail.ot_time_control = 60
        rule_checker.send(:c_ot_min_time, 60, match).should be_true
        match_detail.ot_time_control = 120
        rule_checker.send(:c_ot_min_time, 60, match).should be_true
      end
    end


    context "komi" do
      it "should fail if komi is less than min_komi" do
        match_detail.komi = 3.5
        rule_checker.send(:min_komi, 5.5, match).should be_false
      end

      it "should fail if komi is greater than max_komi" do
        match_detail.komi = 6.5
        rule_checker.send(:max_komi, 5.5, match).should be_false
      end

      it "should check komi is less than or equal to max_komi" do
        match_detail.komi = 4.5
        rule_checker.send(:max_komi, 5.5, match).should be_true
        match_detail.komi = 5.5
        rule_checker.send(:max_komi, 5.5, match).should be_true
      end

      it "should check komi is greater than or equal to min_komi" do
        match_detail.komi = 5.5
        rule_checker.send(:min_komi, 5.5, match).should be_true
        match_detail.komi = 6.5
        rule_checker.send(:min_komi, 5.5, match).should be_true
      end
    end

    context "handicap" do
      it "should fail if handicap is less than min handicap" do
        match_detail.handicap = 3
        rule_checker.send(:min_handicap, 5, match).should be_false
      end

      it "should fail if handicap is greater than max handicap" do
        match_detail.handicap = 6
        rule_checker.send(:max_handicap, 5, match).should be_false
      end

      it "should check handicap is less than or equal to max handicap" do
        match_detail.handicap = 4
        rule_checker.send(:max_handicap, 5, match).should be_true
        match_detail.handicap = 5
        rule_checker.send(:max_handicap, 5, match).should be_true
      end

      it "should check handicap is greater than or equal to min handicap" do
        match_detail.handicap = 5
        rule_checker.send(:min_handicap, 5, match).should be_true
        match_detail.handicap = 6
        rule_checker.send(:min_handicap, 5, match).should be_true
      end

      it "should fail if handicap is not present and handi is required" do
        match_detail.handicap = 0
        rule_checker.send(:handicap_required, true, match).should be_false
      end
    end

  end
end
