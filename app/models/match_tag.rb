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

  belongs_to :match

  attr_accessible :handle, :match_id, :node, :phrase

end
