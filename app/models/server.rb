# == Schema Information
#
# Table name: servers
#
#  id                 :integer          not null, primary key
#  name               :string(100)
#  url                :string(255)
#  scraper_class_name :string(100)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Server < ActiveRecord::Base
  attr_accessible :name, :url

  has_many :accounts
  has_many :events
  has_many :users, through: :accounts

end
