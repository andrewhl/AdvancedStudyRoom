class AddNodeLimitToTags < ActiveRecord::Migration
  def change
    add_column :tags, :node_limit, :integer
  end
end
