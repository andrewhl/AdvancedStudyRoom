class RegistrationGroup < ActiveRecord::Base
  attr_accessible :event_id, :integer, :max_registrations, :min_registrations, :name, :parent_id, :registration_group_type_id

  has_one :registration_group_type
  has_one :event
  has_one :parent, foreign_key: :parent_id, class_name: 'RegistrationGroup'

end
