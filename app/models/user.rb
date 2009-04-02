class User < ActiveRecord::Base
  has_many :topics
  has_many :replies
  has_many :characters

  named_scope :notifiable, {
    :conditions => ["users.email_updates", true]
  }
  
  named_scope :for_post, lambda { |post|
    { :conditions => ["users.id <> ?", post.author_id] } 
  }
end
