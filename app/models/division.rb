class Division < ActiveRecord::Base
  # attr_accessible :title, :body

  has_many :division_players
  belongs_to :tier
end
