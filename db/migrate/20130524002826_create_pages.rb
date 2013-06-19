class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer   :user_id
      t.integer   :sort_order, null: false, default: 0
      t.datetime  :date
      t.text      :body
      t.string    :title
      t.string    :permalink

      t.timestamps
    end
  end
end