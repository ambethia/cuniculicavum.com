class Reply < ActiveRecord::Base
  belongs_to :author, :class_name => "User"
  belongs_to :topic

  def subject
    "Re: #{topic.subject}"
  end

end
