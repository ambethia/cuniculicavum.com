class Post < ActiveRecord::Observer
  observe :topic, :reply
  
  def after_create(post)
    User.notifiable_by_email(post).each do |user|
      begin
        Notification.deliver_post(post, user)
      rescue Net::ProtocolError => e
        # do nothing
      end      
    end
  end

end
