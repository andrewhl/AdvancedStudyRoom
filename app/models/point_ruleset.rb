# == Schema Information
#
# Table name: point_rulesets
#
#  id                       :integer          not null, primary key
#  points_per_win           :float
#  points_per_loss          :float
#  win_decay                :float
#  loss_decay               :float
#  min_points_per_match     :float
#  max_matches_per_opponent :integer
#  point_rulesetable_id     :integer
#  point_rulesetable_type   :string(255)
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#

class PointRuleset < ActiveRecord::Base
  attr_accessible :points_per_win,
                  :points_per_loss,
                  :win_decay,
                  :loss_decay,
                  :pointable_type,
                  :pointable_id,
                  :max_matches_per_opponent,
                  :min_points_per_match

  belongs_to :point_rulesetable, :polymorphic => true

  def rules
    non_rules = [:id, :updated_at, :created_at, :name, :pointable_id, :pointable_type]
    attributes.symbolize_keys.reject { |k,v| non_rules.include?(k) }
  end

end
