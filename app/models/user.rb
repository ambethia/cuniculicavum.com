class User < ActiveRecord::Base
  has_many :topics
  has_many :replies

  named_scope :notifiable_by_email

end
