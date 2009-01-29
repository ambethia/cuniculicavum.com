class AddOfficerToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :officer, :boolean
  end

  def self.down
    remove_column :users, :officer
  end
end
