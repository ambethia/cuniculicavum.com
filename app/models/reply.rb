class Reply < ActiveRecord::Base
  belongs_to :author, :class_name => "User"
  belongs_to :topic, :counter_cache => true

  after_create :set_topics_last_reply

  def mail_subject
    "Re: [Cuniculi Cavum] #{topic.subject}"
  end

  private

    # This has the convenient side-effect of refreshing Topic#updated_at for
    # the topic index's sorting.
    def set_topics_last_reply
      topic.update_attribute :last_reply, self
    end

end
