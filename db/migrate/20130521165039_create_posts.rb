class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer   :user_id
      t.text      :body
      t.datetime  :date
      t.string    :title
      t.string    :permalink

      t.timestamps
    end
  end
end