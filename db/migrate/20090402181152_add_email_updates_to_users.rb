class AddEmailUpdatesToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :email_updates, :boolean, :default => true
  end

  def self.down
    remove_column :users, :email_updates
  end
end
