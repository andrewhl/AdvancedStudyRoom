# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  match_id   :integer
#  node       :integer
#  comment    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ActiveRecord::Base
  attr_accessible :comment, :match_id, :node

  belongs_to :match
end
