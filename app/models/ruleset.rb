# == Schema Information
#
# Table name: rulesets
#
#  id                     :integer          not null, primary key
#  name                   :string(100)
#  overtime_required      :boolean
#  handicap_required      :boolean
#  j_ot_allowed           :boolean
#  c_ot_allowed           :boolean
#  main_time_min          :float
#  main_time_max          :float
#  j_ot_min_period_length :float
#  j_ot_max_period_length :float
#  c_ot_min_time          :float
#  c_ot_max_time          :float
#  min_komi               :float
#  max_komi               :float
#  j_ot_min_periods       :integer
#  j_ot_max_periods       :integer
#  c_ot_min_stones        :integer
#  c_ot_max_stones        :integer
#  min_handicap           :integer
#  max_handicap           :integer
#  min_board_size         :integer
#  max_board_size         :integer
#  node_limit             :integer
#  rulesetable_id         :integer
#  rulesetable_type       :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class Ruleset < ActiveRecord::Base
  attr_protected

  belongs_to :rulesetable, polymorphic: true

  validates_presence_of :name
  validates_length_of   :main_time_min, minimum: 0, allow_blank: true
  validates :main_time_min, numericality: {greater_than_or_equal_to: 0}, allow_blank: true
  validates :main_time_max, numericality: {greater_than_or_equal_to: 0}, allow_blank: true
  validates :j_ot_min_period_length, numericality: {greater_than_or_equal_to: 0}, allow_blank: true
  validates :j_ot_max_period_length, numericality: {greater_than_or_equal_to: 0}, allow_blank: true
  validates :c_ot_min_time, numericality: {greater_than_or_equal_to: 0}, allow_blank: true
  validates :c_ot_max_time, numericality: {greater_than_or_equal_to: 0}, allow_blank: true
  validates :min_komi, numericality: {greater_than_or_equal_to: 0}, allow_blank: true
  validates :max_komi, numericality: {greater_than_or_equal_to: 0}, allow_blank: true
  validates :j_ot_max_periods, numericality: {only_integer: true, greater_than_or_equal_to: 0}, allow_blank: true
  validates :j_ot_min_periods, numericality: {only_integer: true, greater_than_or_equal_to: 0}, allow_blank: true
  validates :c_ot_min_stones, numericality: {only_integer: true, greater_than_or_equal_to: 0}, allow_blank: true
  validates :c_ot_max_stones, numericality: {only_integer: true, greater_than_or_equal_to: 0}, allow_blank: true
  validates :min_handicap, numericality: {only_integer: true, greater_than_or_equal_to: 0}, allow_blank: true
  validates :max_handicap, numericality: {only_integer: true, greater_than_or_equal_to: 0}, allow_blank: true
  validates :min_board_size, numericality: {only_integer: true, greater_than_or_equal_to: 0}, allow_blank: true
  validates :max_board_size, numericality: {only_integer: true, greater_than_or_equal_to: 0}, allow_blank: true
  validates :node_limit, numericality: {only_integer: true, greater_than_or_equal_to: 0}, allow_blank: true

  def rules
    non_rules = [:id, :updated_at, :created_at, :name, :rulesetable_id, :rulesetable_type]
    attributes.symbolize_keys.reject { |k,v| non_rules.include?(k) }
  end

end
