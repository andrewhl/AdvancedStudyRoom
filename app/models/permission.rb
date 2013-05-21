# == Schema Information
#
# Table name: permissions
#
#  id          :integer          not null, primary key
#  perm        :string(255)
#  parent_id   :integer
#  parent_type :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Permission < ActiveRecord::Base
  attr_protected

  belongs_to :parent, :polymorphic => true
end
