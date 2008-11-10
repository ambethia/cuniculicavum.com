class Reply < ActiveRecord::Base
  belongs_to :author, :class_name => "User"
  belongs_to :topic

  def mail_subject
    "Re: [Cuniculi Cavum] #{topic.subject}"
  end

end
