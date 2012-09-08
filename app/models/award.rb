class Award < ActiveRecord::Base
  attr_accessible :achievement_id, :date_awarded, :user_id

  belongs_to :user
  has_many :achievements
end
