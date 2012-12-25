class AddWinnerNameToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :winner_name, :string
    add_column :matches, :winner_id, :integer
    add_index  :matches, :winner_id
  end
end
