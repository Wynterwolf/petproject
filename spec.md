# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app -- require Sinatra gem
- [x] Use ActiveRecord for storing information in a database -- class User INHERITS ActiveRecord::Base
- [x] Include more than one model class (e.g. User, Post, Category) -- Two Models, User and Dog
- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts) -- Posters/Fosters have Multiple Dogs
- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User) -- Dogs belongs to Poster/Foster
- [x] Include user accounts with unique login attribute (username or email) -- email required
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying -- Poster/Foster can only Create, Edit, Delete their own, all can R
- [x] Ensure that users can't modify content created by other users -- Logged in multiple accounts & multiple dogs, users can only edit their own content.
- [x] Include user input validations -- NEED THIS
- [ ] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new) THIS DOESNT WORK/COMMENTED OUT
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code -- Used Markdown for Instructions
 
Confirm
- [x] You have a large number of small Git commits -- Currently at 27
- [x] Your commit messages are meaningful -- Related to filed edited/commands added
- [x] You made the changes in a commit that relate to the commit message -- See Above
- [x] You don't include changes in a commit that aren't related to the commit message -- Also, see above.