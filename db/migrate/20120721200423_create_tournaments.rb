class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|

      t.timestamps
    end
  end
end
