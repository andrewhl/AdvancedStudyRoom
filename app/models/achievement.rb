# == Schema Information
#
# Table name: achievements
#
#  id                :integer          not null, primary key
#  achievement_name  :string(255)
#  earned_image_url  :string(255)
#  pending_image_url :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Achievement < ActiveRecord::Base
  attr_accessible :achievement_name, :earned_image_url, :pending_image_url

  belongs_to :award

end
