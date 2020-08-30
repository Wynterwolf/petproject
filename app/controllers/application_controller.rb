require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    # use sessions and session secret
    set :session, true
    set :sessions_secret, ENV["SESSION_SECRET"]
  end

  get "/" do
    erb :welcome
  end

end
