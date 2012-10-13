# == Schema Information
#
# Table name: servers
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  url        :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Server < ActiveRecord::Base
  attr_accessible :name, :url

  has_many :leagues
  has_many :accounts

end
