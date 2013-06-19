# == Schema Information
#
# Table name: pages
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  sort_order :integer          default(0), not null
#  date       :datetime
#  body       :text
#  title      :string(255)
#  permalink  :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
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
