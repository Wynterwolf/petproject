require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    
    set :public_folder, File.dirname(FILE) + '/static'
  end

  get "/" do
    erb :welcome
  end

end
