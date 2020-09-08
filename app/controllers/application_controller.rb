require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :sessions, true
    set :session_secret, ENV["SESSION_SECRET"]
    set :method_override, true
    register Sinatra::Flash
  end

  get "/" do
    @dogs = Dog.all 
    erb :'/dogs/index.html'
  end

  not_found do
    flash[:error] = "Whoops! I couildn't find that route"
    redirect "/dogs"
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
      flash[:error] = "You must be logged in to view this page"
      redirect "/sessions/login"
    end
  end
end
