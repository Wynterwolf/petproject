require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, File.dirname(FILE) + '/static'
    set :views, 'app/views'
  end

  get "/" do
    erb :welcome
  end

end
