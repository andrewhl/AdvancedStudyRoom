class CreateAchievements < ActiveRecord::Migration
  def change
    create_table :achievements do |t|
      t.string :achievement_name
      t.string :earned_image_url
      t.string :pending_image_url

      t.timestamps
    end
  end
end
