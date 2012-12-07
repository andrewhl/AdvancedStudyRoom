class AddInheritanceToTiers < ActiveRecord::Migration
  def change
    add_column :tiers, :parent, :string
    add_column :tiers, :child, :string

    add_index :tiers, :parent
    add_index :tiers, :child
  end

end
