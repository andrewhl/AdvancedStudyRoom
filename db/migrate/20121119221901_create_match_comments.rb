class CreateMatchComments < ActiveRecord::Migration
  def change
    create_table :match_comments do |t|
      t.integer  :match_id
      t.text     :comment
      t.string   :handle, limit: 100
      t.string   :rank, limit: 5
      t.datetime :date
      t.integer  :node_number
      t.integer  :line_number

      t.timestamps
    end

    add_index :comments, :match_id
  end

end
