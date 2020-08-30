class UsersController < ApplicationController

    get '/users/new' do
        #get form for account creation
        erb :'users/new'
    end

    post '/users' do
        @user = User.new(email: params[:email], password: params[:password])
        if @user.save
            session[:id] = @user.id
            redirect "/"
        else
            erb :'users/new'
        end
    end
end