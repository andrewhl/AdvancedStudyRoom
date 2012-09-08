class Achievement < ActiveRecord::Base
  attr_accessible :achievement_name, :earned_image_url, :pending_image_url

  belongs_to :award

end
