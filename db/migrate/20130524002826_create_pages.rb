class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.datetime :date
      t.integer :user_id
      t.string :html
      t.string :title

      t.timestamps
    end
  end
end
