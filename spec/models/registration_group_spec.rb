# == Schema Information
#
# Table name: registration_groups
#
#  id                         :integer          not null, primary key
#  event_id                   :integer
#  parent_id                  :integer
#  registration_group_type_id :integer
#  name                       :string(100)
#  min_registrations          :integer
#  max_registrations          :integer
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  position                   :integer          default(1), not null
#

require 'spec_helper'

describe RegistrationGroup do
  pending "add some examples to (or delete) #{__FILE__}"
end
