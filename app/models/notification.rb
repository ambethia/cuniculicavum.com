class Notification < ActionMailer::Base
  helper :application

  def post(post, user)
    subject    post.mail_subject
    recipients "#{user.name} <#{user.email}>"
    from       "#{post.author.name} <#{Notification.topic_reply_to(post)}>"
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
    pattern = /^.*Reply above this line.*$/
    message = full_body(mail)
    match   = pattern.match(message)

    clean_reply(match ? match.pre_match.strip : message)
  end

  def full_body(mail)
    if mail.multipart?
      plain = mail.parts.select { |part| part.content_type == "text/plain" }
      body  = plain.first.body || mail.parts.first.body
      body.strip
    else
      mail.body.strip
    end
  end

  # Remove last lines like:
  #   On Nov 27, 2008, at 11:06 PM, Jason L Perry wrote:
  def clean_reply(text)
    pattern = /On .* wrote/
    lines = text.split("\n")
    lines.pop if pattern.match(lines.last)
    lines.join("\n").strip
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
