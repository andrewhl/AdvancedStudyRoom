# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  html       :text
#  user_id    :integer
#  date       :datetime
#  title      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  attr_accessible :date, :html, :title, :user_id

  belongs_to :user

  validates_presence_of :title
end
