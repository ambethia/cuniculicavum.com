class Topic < ActiveRecord::Base
  belongs_to :author, :class_name => "User"
  has_many :replies
  
  def mail_subject
    "[Cuniculi Cavum] #{self.subject}"
  end
end
