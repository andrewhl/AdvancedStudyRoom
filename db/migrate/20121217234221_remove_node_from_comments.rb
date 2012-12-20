class RemoveNodeFromComments < ActiveRecord::Migration

  def change
    remove_column :comments, :node
  end
end
