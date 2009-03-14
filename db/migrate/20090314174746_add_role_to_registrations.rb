class AddRoleToRegistrations < ActiveRecord::Migration
  def self.up
    add_column :registrations, :role, :string
  end

  def self.down
    remove_column :registrations, :role
  end
end
