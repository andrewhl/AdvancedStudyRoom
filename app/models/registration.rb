# == Schema Information
#
# Table name: registrations
#
#  id          :integer          not null, primary key
#  account_id  :integer
#  event_id    :integer
#  division_id :integer
#  handle      :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Registration < ActiveRecord::Base
  attr_accessible :account_id,
                  :event_id, :registration, :division_id, :handle

  belongs_to :event
  belongs_to :account
  belongs_to :division
  has_many :points

  def games
    binding.pry
  end

end
