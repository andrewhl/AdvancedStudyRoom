class AddHandleToComments < ActiveRecord::Migration
  def change
    add_column :comments, :handle, :string
    add_column :comments, :rank, :string
    add_column :comments, :game_date, :datetime
  end
end
