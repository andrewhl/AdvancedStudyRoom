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
  attr_accessible :date, :html, :title, :user_id, :permalink

  belongs_to :user

  validates_presence_of :permalink, :title, :html
  validates_uniqueness_of :title

  validates_format_of :permalink, with: /^[\w\-]+$/, message: "Only alphanumeric characters, underscores, hyphens and spaces are allowed."

  def path
    "/#{permalink}"
  end

  private
    def format_permalink
      self.permalink = permalink.strip.parameterize
    end

end
