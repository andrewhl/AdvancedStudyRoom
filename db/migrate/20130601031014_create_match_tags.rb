class CreateMatchTags < ActiveRecord::Migration
  def change
    create_table :match_tags do |t|
      t.integer :match_id
      t.integer :comment_id
      t.integer :node
      t.string  :phrase, limit: 100
      t.string  :handle, limit: 100

      t.timestamps
    end

    add_index :match_tags, :match_id
    add_index :match_tags, :handle
  end
end
