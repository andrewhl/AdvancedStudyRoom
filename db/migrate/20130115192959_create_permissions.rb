class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.string   :perm
      t.integer  :parent_id
      t.string   :parent_type

      t.timestamps
    end

    add_index :permissions, :parent_id
  end
end
