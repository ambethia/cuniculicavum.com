class Post < ActiveRecord::Observer
  observe :topic, :reply
  
  def after_create(post)
    User.notifiable_by_email.each do |user|
      Notification.deliver_post(post, user)
    end
  end

end
