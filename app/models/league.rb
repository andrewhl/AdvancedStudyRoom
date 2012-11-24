# == Schema Information
#
# Table name: leagues
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  server_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class League < ActiveRecord::Base
  attr_accessible :name, :server_id, :tiers_attributes

  has_many :accounts
  has_many :tiers, dependent: :destroy
  has_one  :tag
  belongs_to :ruleset
  belongs_to :server

  accepts_nested_attributes_for :tiers, allow_destroy: true
end
