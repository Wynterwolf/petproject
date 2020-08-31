require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, File.dirname(__FILE__) + '/public'
    set :views, 'app/views'
    # use sessions and session secret
    set :sessions, true
    set :session_secret, ENV["SESSION_SECRET"]
    #d for patch
    set :method_override, true
  end

  get "/" do
    @dogs = Dog.all 
    erb :'/dogs/index.html'
  end

  not_found do
    # flash[:error] = "Whoops! I couildn't find that route"
    redirect "/posts"
  end

  private

  def current_user
    User.find_by_id(session[:id])
  end

  def logged_in?
    !!current_user
  end

  def redirect_if_not_logged_in
    if !logged_in?
      # flash[:error] = "You must be logged in to view this page"
      redirect request.referrer || "/login"
    end
  end
end
