class Post < ActiveRecord::Base
  attr_accessible :date, :html, :title, :user_id

  belongs_to :user

  validates_presence_of :title
end
