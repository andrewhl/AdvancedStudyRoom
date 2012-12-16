class AddLineNumberToComments < ActiveRecord::Migration
  def change
    add_column :comments, :line_number, :integer
  end
end
