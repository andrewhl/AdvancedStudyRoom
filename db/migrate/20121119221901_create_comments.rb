class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer  :match_id
      t.text     :comment
      t.string   :handle
      t.string   :rank
      t.datetime :date
      t.integer  :node_number
      t.integer  :line_number

      t.timestamps
    end

    add_index :comments, :match_id
  end

end
