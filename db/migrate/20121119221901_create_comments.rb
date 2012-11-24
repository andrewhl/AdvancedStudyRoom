class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :match_id
      t.integer :node
      t.string :comment

      t.timestamps
    end

    add_index :comments, :match_id
  end

end
