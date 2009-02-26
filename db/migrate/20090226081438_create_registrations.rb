class CreateRegistrations < ActiveRecord::Migration
  def self.up
    create_table :registrations do |t|
      t.string :status
      t.integer :character_id
      t.integer :event_id

      t.timestamps
    end
  end

  def self.down
    drop_table :registrations
  end
end
