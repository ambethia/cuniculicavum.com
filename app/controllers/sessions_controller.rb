class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :create
  skip_before_filter :require_authentication
  skip_before_filter :require_activation

  def show
    redirect_to login_path
  end

  def create
    authenticate_with_open_id(params[:opendid_url], :required => [:fullname, :email], :optional => [:timezone]) do |result, identity_url, registration|
      if result.successful?
        @user = User.find_or_initialize_by_identity_url(identity_url)
        if @user.new_record?
          @user.name      = registration["fullname"]
          @user.email     = registration["email"]
          @user.time_zone = ActiveSupport::TimeZone::MAPPING.index(registration["timezone"])
          @user.save(false)
          self.current_user = @user
          flash[:notice] = "Notify the guild leader that your account needs to be activated."
          redirect_to current_user_path
        else
          self.current_user = @user
          redirect_to topics_path
        end
      else
        flash[:warning] = result.message
        redirect_to login_path
      end
    end
  end

  def destroy
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_to root_path
  end
end
