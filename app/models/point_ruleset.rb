class PointRuleset < ActiveRecord::Base
  attr_accessible :type,
                  :parent_id,
                  :points_per_win,
                  :points_per_loss,
                  :point_decay


  belongs_to :parent, :polymorphic => true


end
