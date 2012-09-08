class CreateKgsHandles < ActiveRecord::Migration
  def change
    create_table :kgs_handles do |t|
      t.integer :user_id
      t.string :kgs_handle
      t.integer :league_tier
      t.integer :league_active
      t.integer :kgs_rank

      t.timestamps
    end

    add_index :kgs_handles, :user_id
  end
end
