class Topic < ActiveRecord::Base
  belongs_to :author, :class_name => "User"
  belongs_to :last_reply, :class_name => "Reply"
  has_many :replies
  
  def mail_subject
    "[Cuniculi Cavum] #{self.subject}"
  end
end
