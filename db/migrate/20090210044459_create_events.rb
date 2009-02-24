class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :title
      t.text :description
      t.datetime :begins_at
      t.datetime :ends_at
      t.integer :raid_id

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
