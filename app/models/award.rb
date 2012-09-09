# == Schema Information
#
# Table name: awards
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  achievement_id :integer
#  date_awarded   :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Award < ActiveRecord::Base
  attr_accessible :achievement_id, :date_awarded, :user_id

  belongs_to :user
  has_many :achievements
end
