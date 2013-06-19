class CreateServers < ActiveRecord::Migration
  def change
    create_table :servers do |t|
      t.string :name, limit: 100
      t.string :url
      t.string :scraper_class_name, limit: 100

      t.timestamps
    end
  end
end
