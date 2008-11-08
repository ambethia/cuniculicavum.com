class Post < ActiveRecord::Observer
  observe :topic, :reply
  
  def after_create(post)
    Notification.deliver_post(post)
  end

end
