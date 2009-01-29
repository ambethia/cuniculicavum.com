# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :require_authentication, :except => :splash
  before_filter :require_activation,     :except => :splash

  before_filter :set_time_zone

  helper_method :logged_in?, :current_user

  # GET /
  def splash
    render :template => "layouts/splash"
  end

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

    def require_activation
      unless logged_in? && current_user.activated?
        flash[:warning] = "Notify the guild leader that your account needs to be activated."
        redirect_to root_path
        false
      else
        true
      end
    end
    
    def require_authentication
      unless logged_in?
        flash[:warning] = "You are not logged in."
        redirect_to login_path
        false
      else
        true
      end
    end
    
    def require_officer
      unless logged_in? && current_user.officer?
        flash[:warning] = "You are not an officer."
        redirect_to root_path
        false
      else
        true
      end
    end

end
