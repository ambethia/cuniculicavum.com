class Topic < ActiveRecord::Base
  belongs_to :author, :class_name => "User"
  has_many :replies
end
