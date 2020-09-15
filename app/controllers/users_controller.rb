class UsersController < ApplicationController

    get '/users/new' do
        #get form for account creation
        @user = User.new
        erb :'users/new'
    end

    post '/users' do
        @user = User.new(email: params[:email], password: params[:password])
        if @user.save
            session[:id] = @user.id
            redirect "/"
        else
            erb :'users/new'
            #needs an error
        end
    end

    get '/users/:id' do
        #Work on the show page to display user information
    
        #greet user

        #list their owned dogs

        #edit button for changing username
        erb: 
    end
end