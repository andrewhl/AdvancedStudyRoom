# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  email               :string(255)
#  username            :string(255)
#  access_level        :integer
#  password_reset_flag :boolean
#  last_signed_in      :datetime
#  last_scraped        :datetime
#  points              :float
#  month_points        :float
#  lifetime_points     :float
#  first_name          :string(255)
#  last_name           :string(255)
#  password_digest     :string(255)
#  admin               :boolean
#  rank                :integer
#  kgs_rank            :integer
#  kaya_rank           :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class User < ActiveRecord::Base
  has_secure_password

  attr_accessible :email, :password, :password_confirmation, :first_name, :last_name

  validates_presence_of :email
  validates_uniqueness_of :email
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i

  has_many :accounts
  has_many :awards
end
