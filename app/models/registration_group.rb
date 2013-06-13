# == Schema Information
#
# Table name: registration_groups
#
#  id                         :integer          not null, primary key
#  event_id                   :integer
#  parent_id                  :integer
#  registration_group_type_id :string(255)
#  integer                    :string(255)
#  name                       :string(100)
#  min_registrations          :integer
#  max_registrations          :integer
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#

class RegistrationGroup < ActiveRecord::Base
  attr_accessible :event_id, :integer, :max_registrations, :min_registrations, :name, :parent_id, :registration_group_type_id

  has_one :registration_group_type
  has_one :event
  has_one :parent, foreign_key: :parent_id, class_name: 'RegistrationGroup'

end
