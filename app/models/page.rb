# == Schema Information
#
# Table name: pages
#
#  id         :integer          not null, primary key
#  date       :datetime
#  user_id    :integer
#  html       :text(255)
#  title      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  sort_order :integer
#  permalink  :string(255)
#

class Page < ActiveRecord::Base
  before_validation :format_permalink

  attr_accessible :date, :html, :title, :user_id, :sort_order

  validates_presence_of :permalink, :title, :html
  validates_uniqueness_of :title

  validates_format_of :permalink, with: /^[\w\-]+$/, message: "Only alphanumeric characters, underscores, hyphens and spaces are allowed."

  default_scope order('sort_order ASC')

  def path
    "/#{permalink}"
  end

  private
    def format_permalink
      self.permalink = permalink.strip.parameterize
    end

end
