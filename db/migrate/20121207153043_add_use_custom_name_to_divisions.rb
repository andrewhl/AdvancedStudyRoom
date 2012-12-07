class AddUseCustomNameToDivisions < ActiveRecord::Migration
  def change
    add_column :divisions, :use_custom_name, :boolean
  end
end
