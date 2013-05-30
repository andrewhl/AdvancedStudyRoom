class AddPermalinkToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :permalink, :string
  end
end
