# == Schema Information
#
# Table name: match_comments
#
#  id          :integer          not null, primary key
#  match_id    :integer
#  comment     :text
#  handle      :string(100)
#  rank        :string(5)
#  date        :datetime
#  node_number :integer
#  line_number :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class MatchComment < ActiveRecord::Base
  # attr_accessible :comment,
  #                 :match_id,
  #                 :node_number,
  #                 :line_number,
  #                 :handle,
  #                 :rank,
  #                 :date

  belongs_to :match
end
