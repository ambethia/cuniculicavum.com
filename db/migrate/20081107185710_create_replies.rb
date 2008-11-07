class CreateReplies < ActiveRecord::Migration
  def self.up
    create_table :replies do |t|
      t.integer :topic_id
      t.integer :author_id
      t.text :body

      t.timestamps
    end
  end

  def self.down
    drop_table :replies
  end
end
