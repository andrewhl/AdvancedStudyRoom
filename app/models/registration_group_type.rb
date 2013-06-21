# == Schema Information
#
# Table name: registration_group_types
#
#  id          :integer          not null, primary key
#  name        :string(100)
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class RegistrationGroupType < ActiveRecord::Base
  has_many :registration_groups

  attr_accessible :description, :name
end
