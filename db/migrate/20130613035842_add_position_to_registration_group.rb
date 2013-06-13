class AddPositionToRegistrationGroup < ActiveRecord::Migration
  def change
    add_column :registration_groups, :position, :integer, null: false, default: 1
  end
end
