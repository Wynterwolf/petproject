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
        @user = User.find_by_id(params[:id])
            if @user.nil?
                flash[:error] = "No user by that name"
                redirect "/user/show.html"
            end
        #greet user
            @dogs = @user.dogs
        #list their owned dogs

        #edit button for changing username
        erb :'/users/show.html'
    end

    get "/users/:id/edit" do
        set_user
        redirect_if_not_authorized
        erb :"/users/edit.html"
    end

    patch "/users/:id" do
        set_user
        redirect_if_not_authorized
        if @user.update(email: params[:user][:email])
           flash[:success] = "User successfully updated"
          redirect "/users/#{@user.id}"
        else 
          erb :"/users/edit.html"
        end
      end
    
    private
    
    def set_user
        @user = User.find_by_id(params[:id])
        if @user.nil?
            flash[:error] - "No user found"
            redirect "/"
        end
    end

    def redirect_if_not_authorized
        redirect_if_not_logged_in
        if !authorize_user(@user)
            flash[:error] = "No permission"
            redirect "/"
        end
    end

    def authorize_user(user)
        current_user == user
    end
end
