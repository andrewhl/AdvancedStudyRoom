class AddWonByToMatch < ActiveRecord::Migration
  def change
    add_column :matches, :won_by, :string
  end
end
