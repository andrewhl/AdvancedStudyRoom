class AddCustomNameToDivisions < ActiveRecord::Migration
  def change
    add_column :divisions, :custom_name, :string
  end
end
