ActionController::Routing::Routes.draw do |map|
  map.resources :topics, :has_many => :replies
  map.resources :events, :has_many => :registrations
  map.resources :characters

  map.resource :session
  map.logout   "/logout", :controller => "sessions", :action => "destroy"
  map.login    "/login",  :controller => "sessions", :action => "new"

  # A hybrid singular/plural resource.
  map.with_options :controller => "users" do |map|
    map.current_user "/user", :action => "edit",    :conditions => { :method => :get }
    map.current_user "/user", :action => "destroy", :conditions => { :method => :delete }
    map.current_user "/user", :action => "update",  :conditions => { :method => :put }

    map.users "/users",     :action   => "index"
    map.user  "/users/:id", :action   => "show"

    map.activate_user "/users/:id/activate", :action => "activate", :conditions => { :method => :put }
  end

  map.root :controller => "application", :action => "splash"
end
