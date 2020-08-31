class DogsController < ApplicationController

  # GET: /dogs -> index
  get "/dogs" do
    @dogs = Dog.all
    erb :"/dogs/index.html"
  end

  # GET: /dogs/new -> new
  get "/dogs/new" do
    redirect_if_not_logged_in
    @dog = Dog.new
    erb :"/dogs/new.html"
  end

  # POST: /dogs -> create
  post "/dogs" do
    redirect_if_not_logged_in
    @dog = current_user.dogs.build(name: params[:dog][:name], age: params[:dog][:age], breed: params[:dog][:breed])
    if @dog.save
      redirect "/dogs"
    else
      erb :"/dogs/new.html"
    end
  end

  # GET: /dogs/5 -> show
  get "/dogs/:id" do
    set_dog
    erb :"/dogs/show.html"
  end

  # GET: /dogs/5/edit -> edit
  get "/dogs/:id/edit" do
    set_dog
    redirect_if_not_authorized
    erb :"/dogs/edit.html"
  end

  # PATCH: /dogs/5 -> update
  patch "/dogs/:id" do
    set_dog
    redirect_if_not_authorized
    if @dog.update(name: params[:dog][:name], age: params[:dog][:age], breed: params[:dog][:breed])
      flash[:success] = "Post successfully updated"
      redirect "/dogs/#{@post.id}"
    else 
      erb :"/dogs/edit.html"
    end
  end

  # DELETE: /dogs/5 - destroy
  delete "/dogs/:id" do
    set_dog
    redirect_if_not_authorized
    @dog.destroy
    redirect "/dogs"
  end

  private 

  def set_dog
    @dog = Dog.find_by_id(params[:id])
    if @dog.nil?
      flash[:error] = "Couldn't find a Dog with id: #{params[:id]}"
      redirect "/dogs"
    end
  end

  def redirect_if_not_authorized
    redirect_if_not_logged_in
    if !authorize_post(@post)
      # flash[:error] = "You don't have permission to do that action"
      redirect "/dogs"
    end
  end

  def authorize_post(post)
    current_user == post.author
  end

end