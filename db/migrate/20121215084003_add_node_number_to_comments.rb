class AddNodeNumberToComments < ActiveRecord::Migration
  def change
    add_column :comments, :node_number, :integer
  end
end
