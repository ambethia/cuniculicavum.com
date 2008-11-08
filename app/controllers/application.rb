# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_time_zone
  before_filter :authenticate

  helper_method :logged_in?, :current_user

  protected

    def logged_in?
      !!current_user # tisk, tisk
    end

    def current_user
      @current_user ||= self.current_user = User.find_by_id(session[:user_id])
    end

    def current_user=(user)
      session[:user_id] = user ? user.id : nil
      @current_user = user || false
    end

    def set_time_zone
      Time.zone = current_user.time_zone if logged_in?
    end

    def authenticate
      unless logged_in?
        flash[:warning] = "You have not been authorized to perform that action."
        redirect_to login_path
        false
      else
        true
      end
    end

end
