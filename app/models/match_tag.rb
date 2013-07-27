# == Schema Information
#
# Table name: match_tags
#
#  id         :integer          not null, primary key
#  match_id   :integer
#  comment_id :integer
#  node       :integer
#  phrase     :string(100)
#  handle     :string(100)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class MatchTag < ActiveRecord::Base

  before_validation :format_phrase

  belongs_to :match

  # attr_accessible :handle, :match_id, :node, :phrase

  private

    def format_phrase
      tag_phrase = phrase.strip
      self.phrase = '#' + tag_phrase unless tag_phrase =~ /^\#/
    end

end
