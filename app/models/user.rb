class User < ActiveRecord::Base
  has_many :topics
  has_many :replies
  has_many :characters

  named_scope :notifiable_by_email, lambda { |post|
    { :conditions => ['users.id <> ?', post.author_id] }
  }
end
