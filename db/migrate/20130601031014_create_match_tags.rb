class CreateMatchTags < ActiveRecord::Migration
  def change
    create_table :match_tags do |t|
      t.integer :node
      t.integer :match_id
      t.integer :comment_id
      t.string :phrase
      t.string :handle

      t.timestamps
    end

    add_index :match_tags, :match_id
    add_index :match_tags, :handle

  end
end
