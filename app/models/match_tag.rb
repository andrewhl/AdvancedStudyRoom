# == Schema Information
#
# Table name: match_tags
#
#  id         :integer          not null, primary key
#  node       :integer
#  match_id   :integer
#  comment_id :integer
#  phrase     :string(255)
#  handle     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class MatchTag < ActiveRecord::Base

  before_validation :format_phrase

  belongs_to :match

  attr_accessible :handle, :match_id, :node, :phrase

  validates :node,
    presence: true,
    numericality: {only_integer: true, greater_than: 0}

  private

    def format_phrase
      tag_phrase = phrase.strip
      self.phrase = '#' + tag_phrase unless tag_phrase =~ /^\#/
    end

end
