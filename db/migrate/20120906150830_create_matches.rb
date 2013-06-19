class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer  :registration_group_id
      t.string   :digest
      t.string   :url
      t.string   :validation_errors
      t.boolean  :valid_match
      t.boolean  :tagged
      t.boolean  :has_points, null: false, default: false
      t.datetime :completed_at

      t.timestamps
    end

    add_index :matches, :registration_group_id
  end
end