class AddPrizesDescriptionToEvent < ActiveRecord::Migration
  def change
    add_column :events, :prizes_description, :text
  end
end
