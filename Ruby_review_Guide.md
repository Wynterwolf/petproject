


> Written with [StackEdit](https://stackedit.io/).
## Sinatra Project Review

In order to **implement Authentication in Sinatra**, we're going to need to address the following tasks:

1. **Enable** the rack session cookie **middleware**.
2. **Generate** a **session** **secret** so that our cookies are securely encrypted.
3. **Create** a `User` **model** that stores a unique email/username and encrypted password
4. **Implement** the `has_secure_password` **macro** in the `User` model to enable storing an encrypted version of the password and authenticating against that.
5. **Build forms** for sign up and log in and links to the routes that render them
6. **Build out controllers** that handle rendering forms and responding to their submission
7. **Use the methods** from `has_secure_password` **to create user accounts and authenticate** them later, storing the user's ID in session cookies using the `session` hash in our controllers.

## Dependencies (Gems/Packages)
activerecord 
 - **Adds methods to our classes** that help us **create and persist objects & relationships** 
 
bcrypt  
 - **Password Encryption** for the string that's passed in (dependency of has_secure_password)

dotenv
 - **Used to create a hidden file in which we can store credentials** (API Keys, email addresses, etc)
 - We add this file to .gitignore, so it won't be tracked in version control 
 - The constants defined in the .env file are accessible within the ENV constant in our app after we run Dotenv.load session_secret_generator 
 - Creates a cryptographically random string of hexadecimal characters.

session_secret
 - **Creates a cryptographically** random string of hexadecimal characters. 
 - Used with session_secret 
 - Store the result in SESSION_SECRET within the .env file
 - Store the result in SESSION_SECRET within the .env file
 
 Tux 
 - Tux dresses up sinatra for interactive use. 
 - If you have models, you can also interact with them using tux 
 - Extra Info 
	 - We use it to interact with your helpers, view rendering and your app's response objects.
	 - Tux also gives you commands to view your app's routes and settings
	 - https://github.com/cldwalker/tux

## Configuration (environment variables/other stuff in config folder)
Summary: 

 - Enable sessions in the controller 
 - set session secret in controller to `ENV['SESSION_SECRET']
 - ` create `SESSION_SECRET` in a file called .env 
 - load the variables in the `.env` file using `Dotenv.load` in "config/environment" 

Make sure the config.ru file uses our new Controller "PostsController" `config.ru` needs to `use` our new controller `PostsController` 

To Test It's Working 

 1. Open `bundle exec tux`
 2. Type in `ENV['SESSION_SECRET']`
 3. You Should See The Value Inside Of The `.env` file. 

**Note** - Eventually we'll have to load our 2 controllers within the `config.ru` file as well We will need to add "method_override" so that we're able to send a delete request for `logout`

**Database** 
We'll need a `users` table with a column `password_digest` 
We'll also need an additional column to find a user by (email or username) 

**PostsTable** 
Add a posts table with 3 columns 
 - **title**:string 
 - **content**:text 
 - **author_id**:integer

**Models**
 - User Model
	 - We need a "User Model" that inherits from "ActiveRecord::Base"
	 - It should invoke the "has_secure_password" macro
	 
**Post Model**
 - Add a Post Model that belongs_to an author (a User)

**Views**
 - We need a view with a "registration form" for "creating a new account" 
 - We need a view with "login form" for "logging into an existing account"
 - We need to have "navigation links" in "layout.erb"
 
 **Navigation Links** 
 - This is used for Navigation and it helps us implement Conditional Logic
 - It should have Conditional Logic for Displaying Buttons (login, logout, sign up)
 - We have to implement yield so the same thing appears on every page.

**Views Files**
 - index view
	 - Shows a list of posts with links to the full post
 - show view
	 - Displays a full post
 - new view
	 - Displays form to create a new post
 - edit view
	 - Displays form so we can update an existing post. 
	  
**Controllers**
 - SessionsController
	 - For Logging In and Logging Out
 - UsersController
	 - For Creating New Accounts
 - PostsController
	 - For CRUD actions for posts
	 
**Routes (HTTP VERB + PATH)** 
 - get "/login" 
	 - Renders The Log In Form
 - post "/login" 
	 - Handles The Log In Form Submission 
 - delete "/logout" 
	 - Handles Log Out Button Click. Clears Session. 
 - get "/users/new" 
	 - Renders The Registration Form 
 - post "/users" 
	- Handles The Registration Form Submission 
 - get "/posts" 
	- Index of Posts. Shows All Posts. 
 - get "/posts/new" 
	- Renders Form To Create a New Post 
 - post "/posts" 
	- Handles New Form Submission 
 - get "/posts/:id" 
	- Detail Page For A Single Post 
 - get "/posts/:id/edit" 
	- Form To Edit Existing Post (only viewable by author of post) 
 - patch "/posts/:id" 
	- Handle edit post form submission (only editable by author of post) 
 - delete "/posts/:id" 
	- Delete a particular post (only deletable by author of post)

**HTTP VERBS** 
 - POST (CREATE) 
 - GET (READ)
 - PUT (UPDATE) 
 - PATCH (UPDATE)
 - DELETE (DELETE)

## Corneal (What Does It Do?)

Gives you generator commands that can: 
 - Create a new sinatra application
 - Add a model/migration to an existing sinatra application
 - Add a controller/with routes/views to an existing application (also adds controller to the config.ru file) 

**Corneal Commands** 
 - corneal new APP_PATH
	 - Creates a New Sinatra Application // `We run this to start the app`
 - corneal scaffold NAME
	 - Generates a Model/Migration With Its Associated Views, Controllers and Routes
 - corneal model NAME
	 - Generates a Model and Migration
 - corneal controller NAME
	 - Generates a Controller with Routes and Views
 - corneal help
	 - Allows you to see a list of commands 
 - corneal help [COMMAND]
	 - Describes Available Commands or One Specific Command
 - corneal -v
	 - Shows Corneal Version Number

**Notes** 
We’ll Use "Scaffold Generator"
 - It will create a Model, Migration To Create An Associated Table, Controller with a matching name, and a Views directory with four files.
 - It will also add the controller to the `config.ru` file and tell it to use that controller. 
 - If we pass in `additional arguments` after the name of the model, we will add columns to our migration. 
	 - The default column type is string. 
	 - We can add a colon after the name of the column and specify another column type. 

**We Run The Following:**
`corneal scaffold Post title:string content:text author_id:integer` 

**We Get This Printed** 

 - create app/models/post.rb 
 - create db/migrate/20200827232626_create_posts.rb
 - create app/controllers/posts_controller.rb 
 - insert config.ru 
 - create app/views/posts 
 - create app/views/posts/edit.html.erb 
 - create app/views/posts/index.html.erb 
 - create app/views/posts/new.html.erb 
 - create app/views/posts/show.html.erb 

## Associate Users and Posts

Post Class: 
**belongs_to :author, class_name: "User"**
	 - This informs ActiveRecord to find a User Instance that’s associated with a Post we call this method on, NOT an Author Instance. 
		 - The foreign_key :author_id is inferred from the fact that we have a belongs_to :author 
		 - If the foreign_key was something else, we would also have to add a foreign key "something_else_id" 
		 

> class Post < ActiveRecord::Base 
> belongs_to :author, class_name: "User" 
> validates :title, presence: true 
> validates :content, presence: true 
> end

User class: 
**has_many :posts, foreign_key: "author_id"** 
 - Because our foreign_key is author_id we need to specify that in the option passed to has many (if we don’t, activerecord will assume the foreign key is user_id because we are invoking the macro from the User class)
 

>  class User < ActiveRecord::Base  has_secure_password  validates
> :email, presence: true, uniqueness: true  has_many :posts,
> foreign_key: "author_id"  end

## To Add An Index 
We Get All Of The Posts and Iterate Over Them In The Corresponding View
> class PostsController < ApplicationController  
> get "/posts" do 
> 	@posts = Post.all
> erb :"/posts/index.html"
> end
```
<h1>Posts</h1>
<% @posts.each do |post| %>
<p><a href="/posts/<%= post.id %>"><%= post.title %></a></p>
<% end %>
```
**show.html.erb**

 - For show we need to find a Post using the id that’s coming through the params hash.
	 - We need the one that’s captured by the Dynamic Route.
 - Then, we can show the details in the "show.html.erb" view template.
```
<h1><%= @post.title %></h1>
<p><%= @post.author.email %></p>
<p><%= @post.content %></p>
<% if authorize_post(@post) %>
```

## For Assessment

 - What determines where the browser sends a request upon submission?
	 - method = "" and action= "" attribute values
	 - Method is the HTTP Verb and the Action is the path it’s sent to
 - What determined the Keys in the params hash that appear in the controller upon form submission?
	 - The value of the "name" attributes in your form inputs
	 -  
When We Add Our Form It Will Look Something Like This:
```
<form method="post" action="/posts">
<p>
<div><label for="title">Title</label></div>
<input id="title" type="text" name="post[title]" value="<%= @post.title %>" />
</p>
<p>
<div><label for="content">content</label></div>
<textarea rows="8" cols="45" id="content" type="text" name="post[content]"><%= @post.content %></textarea>
</p>
<input type="submit" value="Create Post" />
</form>
```
 - The value attribute
	 - The value attribute will have the title from the previous post.
	 - If it’s a new post, it will be empty.
	 - In the name attribute, both post and title are keys.
 - The `<textarea>` tag
	 - When using textarea the erb tags are placed at the end of text area as shown.
	 - This is not a self closing tag.
	 - This way the content will still persist upon form reloading.

 - Displaying Errors
	 - In the View we can handle displaying errors by copying this code from Rails Guides for ActiveRecord Validations.

## Adding An Edit Form

Using Templates

 - We can use our new form as a Template
 - This is because of the choice we have made regarding displaying errors and making sure the values for our inputs reflect the values stored in our @post instance variable.

Steps

 - We copy new.html.erb and paste it in "edit.html.erb"
 - We add a "method override" input to our form to send a Patch Request instead of a Post 

Request

 - We change the header from "New Post" to "Edit Post"
 - We update the form action
	 - `<form method="post" action="/posts">` *NEW FORM*
	 - `<form method="post" action="/posts/<%= @post.id %>">` *EDIT FORM*

## Adding Error Handling For When We Don’t Find a Record
 - "Record is not found"
	 - When we encounter this using Post.find_by_id we can add a method that find the record and redirects with an error message if the record is not found
 - Middleware
	 - In order to display a flash message after a redirect, additional middleware is required.
	 - This middleware will allow us to write cookies, so some data will be persistent for a Single Request /Response Cycle and then it will be cleared.
 - Steps
	 - Install Sinatra Flash by typing in gem install sinatra-flash and add it to your gemfile
	 - Run bundle install
	 - register Sinatra::Flash in the application_controller.rb file configuration section
	 - Add the styled_flash view helper to your layout.erb file (this displays the flash messages)
	 - Create flash[:error] = “my error goes here” in a controller and then the next response will include your error.
```
class ApplicationController < Sinatra::Base
configure do
	set :public_folder, 'public'
	set :views, 'app/views'
	set :sessions, true
	set :session_secret, ENV["SESSION_SECRET"]
	set :method_override, true
	register Sinatra::Flash
end
```
styled_flash 
 - We add "styled_flash" view helper to our "layout.erb" file. 
	 - `<%= styled_flash %>` 
- Now we can use Flash Messages to Display Text to our users after redirects. 
- This is used for session based messaging 
- It allows us to Display Error after a redirect by temporarily storing the error message layout.erb 
- This is what Sinatra uses whenever we call an erb method 
- When we call an erb method we are rendering a template at the path we specify 
- This layout file is a kind of container that we render the template into inside of yield 

How Do We Make Navigation Links Appear On Every Page?
- We use the layout.erb file and add navigation links above yield 
- In order to add navigation links we use `<nav> </nav> `tags

## Adding a Private Method To The PostsController
The "private" method will be added to the PostsController 

It will find a Post based on "params[:id]" and then redirect to "/posts" with an error message if it doesn’t find a Post with that id.

```
private
def set_post
	@post = Post.find_by_id(params[:id])
	if @post.nil?
		flash[:error] = "Couldn't find a Post with id: #{params[:id]}"
		redirect "/posts"
	end
end
```

## Calling The Private Method

 - We can now call our private methods from the routes in our Controller.
 - The routes in the controller need to "find" a Post based on the "id" in params

Building Out The Update Functionality
`authorize_post(post)` #AUTHORIZATION CHECK 
`patch "/posts/:id"` #UPDATE 
`redirect_if_not_authorized` #REDIRECTS IF NOT AUTHORIZED 

Only The Users Who Created a Post Can Update It or Delete It

 - The DRY method of doing this is to add a method that accepts a post as an argument
 - This method needs to ensure that the logged in user has permissions to interact with that post
 - We also made a method that redirects the current_user if they are not authorized to perform an action such as update, edit, or delete.
 - One we have these methods we want to invoke it right before we do anything that only an authorized user on a post would be allowed to do.

Protecting Routes Behind a Log In Requirement

 - This is to make sure that only logged in users can visit certain routes (for example we may not want to allow non-logged in users from visiting the routes that create new records/edit existing ones)
 - We can add a private method in the ApplicationController class.
## Example application_controller.rb
```
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
@posts = Post.all
erb :"/posts/index.html"
end

not_found do
flash[:error] = "Whoops! Couldn't find that route"
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
flash[:error] = "You must be logged in to view that page"
redirect request.referrer || "/login"
end
end
end
redirect_if_not_logged_in
```

 - We can call this method in any controller action (route) where we want only logged in users to be able to go
 - Now we can use Conditional Logic in Views To Display Links and Buttons When Needed CRUD Functionality Established

## Terminology For Forms
 - **method**
	 - GET or POST
	 - These are HTTP VERBS
	 - This is used even when you need to make a patch or delete request
 - **action**
	 - This refers to the path that the request will be sent to. This should match a path in your routes.
	 - `<form method=”post” action="/users">` will send a request that matches the route `post ‘/users’`
 - **type**
	 - What it feels like to interact with the input
	 - text, url, password, submit, read more on MDN
 - **name**
 - When you submit the form this is how the input value is found within params
 - The value of `<input name="post[title]" /> will be accessed by params[:post][:title]` in controller
-  **id**
	- Used to link with label
	- links with `for= "" if you have <label for=”title”>Title</label> and <input id=”title” />` then clicking on the Title label will pull the title input into focus
- **value**
	- The value stored in that input, for text fields, this will be the text inside the field when the page loads, for submit inputs, this is the button tex
	- The value inside of an input when a form is submitted will be the value accessible in the params hash.
- **div**
	- Used for blocks (stacks on top of other blocks)
- **labels**
	- Used for inline (won’t create a new line but will be displayed in the same line it’s added)
	

## Creating Our Controllers and Routes For Log In

> class SessionsController < ApplicationController
>  get '/login' do 
>  erb:'/sessions/login' 
>  end
```
post '/login' do
# find the user by their email:
user = User.find_by_email(params[:email])

# Authenticates the user and either logs them in or returns them to login.
# if @user.try(:authenticate, params[:password] is another option)

if user && user.authenticate(params[:password])
session[:id] = user.id
redirect "/"
else

# @error is also present in login.erb

@error = "Incorrect email or password"
erb :'/sessions/login'
end
end

delete '/logout' do
session.clear
redirect "/"
end
end
```
**Important Difference in app/views/sessions/login.erb**
 - We want to check if the credentials that the user has inputted match with an existing user.
 - This is why "has_secure_password", "validates", and "uniqueness" are important
```
<h1>Log In</h1>
<%= @error %>
<form method="post" action="/login">
<p>
<div><label for="email">Email</label></div>
<input type="email" name="email" id="email" />
</p>
<p>
<div><label for="password">Password</label></div>
<input type="password" name="password" id="password" />
</p>
<input type="submit" value="Sign In"/>
</form>
```

## Finding Our User’s ID

 - .find
	 - This method takes an id and gives us the record with that id
	 - If there isn’t one an error will be raised.
 - .find_by
	 - Takes in a Key Value pair and tries to find a matching record.
	 - If there isn’t one it will return nil.
	 - If you forget to pass in a key and just pass in a value, it will return the first record in the table

## Adding Logout Functionality
 - First we Add Navigation so we can get to Sign Up and Log In Pages
 - Whenever we have an "href" it has to match one of our get routes in one of our controllers.
## Example of Layout.Erb
```
<!DOCTYPE html>
<!--[if lt IE 7]> <html class="no-js ie6 oldie" lang="en"> <![endif]--> <!--[if IE 7]> <html class="no-js ie7 oldie" lang="en">
<![endif]--> <!--[if IE 8]> <html class="no-js ie8 oldie" lang="en"> <![endif]--><!--[if gt IE 8]><!-->
<html class="no-js" lang="en"> <!--<![endif]-->
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" />
<title>Authentication</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="/stylesheets/main.css" />
</head>
<body>
<div class="wrapper">
<nav>
<a href="/posts">Posts</a>
<% if !logged_in? %>
<a href="/login">Log In</a>
<a href="/users/new">Sign Up</a>
<% else %>
<a href="/posts/new">New Post</a>
<form method="post" action="/logout" style="display: inline-block;">
<input type="hidden" name="_method" value="delete" />
<input type="submit" value="Log Out" />
</form>
<% end %>
</nav>
<%= styled_flash %>
<%= yield %>
<footer class="branding">
<small>&copy; 2020 <strong>Authentication</strong></small>
</footer>
</div>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<!--[if lt IE 7]> <script src="//ajax.googleapis.com/ajax/libs/chrome-frame/1.0.2/CFInstall.min.js"></script>
<script>window.attachEvent("onload",function(){CFInstall.check({mode:"overlay"})})</script> <![endif]-->
</body>
</html>
```

<!--stackedit_data:
eyJoaXN0b3J5IjpbLTIwNDkxODU2MTEsLTExMzgzMzkzNTAsLT
Y2NjQ2NzA5NCwxNjU5MTIzNzA2LDE5NjkyODkyMTQsNzQzOTc4
MzEzXX0=
-->