class AddNameToDivisions < ActiveRecord::Migration
  def change
    add_column :divisions, :name, :string
  end
end
