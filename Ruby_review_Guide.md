


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

## To Add An Index, We Get All Of The Posts and Iterate Over Them In The Corresponding View

class PostsController < ApplicationController 
get "/posts" do #INDEX 
	@posts = Post.all 
	erb :
<!--stackedit_data:
eyJoaXN0b3J5IjpbMjE4MTE5NzAsNzQzOTc4MzEzXX0=
-->