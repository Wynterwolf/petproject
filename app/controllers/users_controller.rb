class UsersController < ApplicationController

    get '/users/new' do
        #get form for account creation
        erb :'/users/new'
    end

    post '/users' do
    end
end