class AddLastReplyToTopics < ActiveRecord::Migration
  def self.up
    add_column :topics, :last_reply_id, :integer
  end

  def self.down
    remove_column :topics, :last_reply_id
  end
end
