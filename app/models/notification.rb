class Notification < ActionMailer::Base
  helper :application

  def post(post, sent_at = Time.now)
    subject    "[Cuniculi Cavum] #{post.subject}"
    recipients User.notifiable_by_email.map { |u| "#{u.name} <#{u.email}>" }
    from       "#{post.author.name} <#{post.author.email}>"
    reply_to   "Cuniculi Cavum <#{Notification.topic_reply_to(post)}>"
    sent_on    sent_at
    body       :post => post
  end

  def receive(mail)
    author = User.find_by_email(mail.from.first)
    topic  = Topic.find_by_id(Notification.topic_key(mail.to.first))

    if author && topic
      Reply.create(
        :topic  => topic,
        :author => author,
        :body   => reply_body(mail)
      )
    else
    end
  end

  def reply_body(mail)
    if mail.multipart?
      plain = mail.parts.select { |part| part.content_type == "text/plain" }
      body  = plain.first.body || mail.parts.first.body

      body.strip
    else
      mail.body.strip
    end
  end

  # "topic-123@cuniculicavum.com" to 123
  def self.topic_key(address)
    key = address.scan(/topic-(\d+)@.*/).flatten.first
    key ? key.to_i : nil
  end
  
  def self.topic_reply_to(post)
    topic = post.respond_to?(:topic) ? post.topic : post
    "topic-#{topic.id}@#{ActionMailer::Base.default_url_options[:host]}"
  end
end
