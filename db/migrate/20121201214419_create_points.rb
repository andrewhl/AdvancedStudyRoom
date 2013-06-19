class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.integer   :account_id
      t.float     :count
      t.text      :description, limit: 500
      t.string    :disabled_reason
      t.boolean   :disabled, null: false, default: false
      t.datetime  :disabled_at
      t.datetime  :awarded_at

      t.references :pointable, polymorphic: true

      t.timestamps
    end

    add_index :points, :account_id
  end
end