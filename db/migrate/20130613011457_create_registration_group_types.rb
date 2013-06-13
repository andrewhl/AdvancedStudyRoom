class CreateRegistrationGroupTypes < ActiveRecord::Migration
  def change
    create_table :registration_group_types do |t|
      t.string :name, limit: 100
      t.string :description, limit: 255

      t.timestamps
    end
  end
end
