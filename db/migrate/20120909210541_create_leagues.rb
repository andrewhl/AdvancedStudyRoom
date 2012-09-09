class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |t|
      t.string  :name
      t.integer :server_id

      t.timestamps
    end

    add_index :leagues, :server_id
  end
end
