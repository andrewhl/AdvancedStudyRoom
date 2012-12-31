# == Schema Information
#
# Table name: comments
#
#  id          :integer          not null, primary key
#  match_id    :integer
#  comment     :text
#  handle      :string(255)
#  rank        :string(255)
#  game_date   :datetime
#  node_number :integer
#  line_number :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Comment < ActiveRecord::Base
  attr_accessible :comment,
                  :match_id,
                  :node_number,
                  :line_number,
                  :handle,
                  :rank,
                  :game_date

  belongs_to :match
end
