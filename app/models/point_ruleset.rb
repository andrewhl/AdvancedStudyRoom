# == Schema Information
#
# Table name: point_rulesets
#
#  id              :integer          not null, primary key
#  parent_id       :integer
#  parent_type     :string(255)
#  points_per_win  :float
#  points_per_loss :float
#  point_decay     :float
#  type            :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  points_for_game :float
#

class PointRuleset < ActiveRecord::Base
  attr_accessible :type,
                  :parent_id,
                  :points_per_win,
                  :points_per_loss,
                  :point_decay,
                  :parent_type,
                  :points_for_game


  belongs_to :parent, :polymorphic => true


end
