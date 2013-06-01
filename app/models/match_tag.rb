class MatchTag < ActiveRecord::Base

  belongs_to :match

  attr_accessible :handle, :match_id, :node, :phrase

end
