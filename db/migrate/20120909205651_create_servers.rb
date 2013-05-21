class CreateServers < ActiveRecord::Migration
  def change
    create_table :servers do |t|
      t.string :name
      t.string :url
      t.string :scraper_class_name

      t.timestamps
    end
  end
end
