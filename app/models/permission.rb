class Permission < ActiveRecord::Base
  attr_protected

  belongs_to :parent, :polymorphic => true
end
