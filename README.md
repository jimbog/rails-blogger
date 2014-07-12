Building the Application
==

To start building our application we go to the terminal and issue the
following command

```console
rails new blogger -T
```

By entering this command Rails will generate a new application, setting
up folders and files inside a folder under the 'blogger' name.

Rails also installs dependencies by running bundler. This proccess may
take a few minutes. Once it has finished, change to the directory that
rails has created for us by entering:

```console
cd blogger
```
If you type the ```ls -1pa``` you can see all the files that have been
created.

```console
./
../
.gitignore
.ruby-gemset
.ruby-version
Gemfile
Gemfile.lock
README.rdoc
Rakefile
app/
bin/
config/
config.ru
db/
lib/
log/
public/
test/
tmp/
vendor/
````

This is the standard structure of a new Rails application. Once you
learn this structure it makes working with Rails easier since everything
is in a standard place. Next we'll run this fresh application to check
that our Rails install is working properly. Type:

```console
rails server
```

Open your web-brower and head to: [http://localhost:3000](http://localhost:3000) and you should
see a 'welcome aboard page'

Now that you've created the Rails application you should open this
folder using Sublime or your favorite text editor.

Now let's create a git repository to be able to track the changes we
make to our code.

```console
git init
```

And let's add all of our files to be tracked

```console
git add -A
```

And create a commit

```console
git commit -m "initial commit"
```

Creating basic functionality
==

Now we're ready to get started building an actual blog. In your command
prompt press ```Ctrl-c to stop the Rails server, or open a new command
prompt and navigate to your Rails application folder. Then you can use a

Rails generator to build some code for you:

```console
rails g scaffold Post title body:text
```

Rails will generate files and folders

```console
      invoke  active_record
      create    db/migrate/20140712034707_create_posts.rb
      create    app/models/post.rb
      invoke  resource_route
       route    resources :posts
      invoke  scaffold_controller
      create    app/controllers/posts_controller.rb
      invoke    erb
      create      app/views/posts
      create      app/views/posts/index.html.erb
      create      app/views/posts/edit.html.erb
      create      app/views/posts/show.html.erb
      create      app/views/posts/new.html.erb
      create      app/views/posts/_form.html.erb
      invoke    helper
      create      app/helpers/posts_helper.rb
      invoke    jbuilder
      create      app/views/posts/index.json.jbuilder
      create      app/views/posts/show.json.jbuilder
      invoke  assets
      invoke    coffee
      create      app/assets/javascripts/posts.js.coffee
      invoke    scss
      create      app/assets/stylesheets/posts.css.scss
      invoke  scss
      create    app/assets/stylesheets/scaffolds.css.scss
```
An important file that was generated was the migration file:

```console
db/migrate/20140712034707_create_posts.rb
```

You've probably noticed that you have a different set of numbers in yours. This is because the name is corresponds to a timestamp (the time when the file was created).

This file looks like this:

```ruby
class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t| 
      t.string :title
      t.string :picture
      t.text :body

      t.timestamps
    end 
  end 
end
```

This file is some Ruby code that is a database agnostic way to manage
your schema. You can see that this code is to create a table called `Posts` and to create two columns in this table, a title column, a picture column and a body column. Finally we need to instruct Rails to apply this to our database.

Type:

```console
rake db:migrate
```

Once this command has run you can start up your Rails server again with rails server and then navigate to [http://localhost:3000/posts](http://localhost:3000/posts) to see the changes you've made to your application.

From here you can play around with your application. Go ahead and create a new blog post.

Let's add the changes we've introduced so far to our git repository


```console
git add -A
git commit -m "add scaffold of Posts and executed the first migration"
```

You'll notice you can create new posts, edit or delete them. However,
you can also create 'empty' posts. In order to make sure that our posts
have not empty titles and bodies. We're going to add in some functionality to our new Rails app which enforces a rule that every post must have a title and body. Open `app/models/post.rb` and add the line:

```ruby
validates :title, :body, presence: true
```

Validations are used to ensure that only valid data is saved into your
database. You can read more about validations here [active record
validations](http://guides.rubyonrails.org/active_record_validations.html)

So our `post.rb` file will look like this:

```ruby
class Post < ActiveRecord::Base
  validates :title, :body, presence: true
end
``` 
We don't need to validate for the picture field since sometimes there
may be a post without a picture.

We can check that this works by editing our blog post, deleting the title and clicking Update Post. You'll get an error informing you that you've just attempted to break the rule you just inserted.

Now is a good moment to save our work with git againNow is a good moment
to save our work with git again.

  
```console
git add -A
git commit -m "add validations to our post model"
```

Making things prettier
==

Right now our show post page isn't looking very good. We'll open `app/views/posts/show.html.erb` and make it look like the following:

```erb
<p id="notice"><%= notice %></p>

<h2><%= link_to_unless_current @post.title, @post %></h2>
<%= simple_format @post.body %>

<%= link_to 'Edit', edit_post_path(@post) %> |
<%= link_to 'Back', posts_path %>
```

At this point you can refresh the show post page in your browser to see
the changes you've made.

We'll also want to make our blog listing prettier too, we'll use a Rails
partial (a partial is simply a reusuable block of HTML code. It's part
of a web page) to achieve this. We want our listing and the individual
blog pages to look the same so first we'll create a file: 
```console
app/views/posts/_post.html.erb
```
Notice the underscore in front of the filename. This tells Rails that this file is a partial. We'll take:

```erb
 <h2><%= link_to_unless_current @post.title, @post %></h2>
 <%= simple_format @post.body %>
```

Out of `app/views/posts/show.html.erb` and put it in our
`_post.html.erb` file. After that change all the `@post` to be `post` instead. This means
your `_post.html.erb` file will be:

```erb
 <h2><%= link_to_unless_current post.title, post %></h2>
 <%= simple_format post.body %>
```
In our `show.html.erb` file we want insert the code to put our partial into our show view. Insert the code:

```erb
 <%= render :partial => @post %> 
```
In order to obtain:

```erb
<p id="notice"><%= notice %></p>

<%= render :partial => @post %>..

<%= link_to 'Edit', edit_post_path(@post) %> |
<%= link_to 'Back', posts_path %>
```

Save all these files and refresh the show posts page. This is to check
that you haven't broken anything with those changes.

Our index page still hasn't changed though so we're going to open the
index.html.erb file up and remove the table in there and replace it with
the partial again so we're re-using that code:

```erb
<h1>Listing posts</h1>

<%= render :partial => @posts %>

<%= link_to 'New Post', new_post_path %>
```

```console
git add -A
git commit -m "make our posts show and index view niftier by using partials"
```
Adding comments
==

Creating a database model and routing
--

No blog is complete without comments. Lets add them in. On our command
prompt shut down your rails server by hitting `Ctrl-C` in your command
prompt and then type in:

```console
rails generate resource Comment post:references body:text
```

Then you'll want to update your database here to reflect the schema change you've just made:

```console
rake db:migrate
```

After this you'll need to inform Rails that your Posts will potentially have many Comments.

Open `app/models/post.rb`  and somewhere inside the class add the line:

```ruby
has_many :comments
```

```ruby
class Post < ActiveRecord::Base
  has_many :comments
  validates :title, :body, presence: true
end
```

The back-end for your comments is almost complete, we only need to
configure the url that is used to create your comments. Since comments
belong to a post we'll make the URL reflect this. Right now you can see
all the configured URLs by typing `rake routes` in your command prompt. If
you do this now you'll get something like the following:

```console
      Prefix Verb   URI Pattern                  Controller#Action
    comments GET    /comments(.:format)          comments#index
             POST   /comments(.:format)          comments#create
 new_comment GET    /comments/new(.:format)      comments#new
edit_comment GET    /comments/:id/edit(.:format) comments#edit
     comment GET    /comments/:id(.:format)      comments#show
             PATCH  /comments/:id(.:format)      comments#update
             PUT    /comments/:id(.:format)      comments#update
             DELETE /comments/:id(.:format)      comments#destroy
       posts GET    /posts(.:format)             posts#index
             POST   /posts(.:format)             posts#create
    new_post GET    /posts/new(.:format)         posts#new
   edit_post GET    /posts/:id/edit(.:format)    posts#edit
        post GET    /posts/:id(.:format)         posts#show
             PATCH  /posts/:id(.:format)         posts#update
             PUT    /posts/:id(.:format)         posts#update
             DELETE /posts/:id(.:format)         posts#destroy
```

Your URLs (or routes) are configured in all Rails applications in a file
config/routes.rb, open it now and remove the line resources :comments.
Re-run rake routes and you'll notice that all the URLs for comments have
disappeared. Update your routes.rb file to look like the following:

```ruby
Rails.application.routes.draw do
  resources :posts do
    resources :comments
  end
end
```

Because comments will be visible from the show Post page along with the form for creating them, we don't need to have URLs for displaying comment listings, or individual comments. When you rerun rake routes now you'll see the following line:

```console
post_comments POST   /posts/:post_id/comments(.:format) comments#create
```

Before we're finished with the backend for our commenting system we need to write the action that will create our comments.

For more information on actions please read the Rails Guide on [ActionController](http://guides.rubyonrails.org/action_controller_overview.html).

Open app/controllers/comments_controller.rb and and make your code look like the following:

```ruby
class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create!(comment_params)
    redirect_to @post
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end
```

Putting comments into your HTML view
---

You've creating the database model for your comments, migrated your
database, informed Rails of the relationship between comments and posts,
configured a URL that lets you create your comments and created the
controller action that will create the comments. Now you need to display
any comments that have been submitted for a post, and allow users to
submit comments. Open app/views/posts/show.html.erb and make it look
like:

```erb
<p id="notice"><%= notice %></p>

<%= render :partial => @post %>

<%= link_to 'Edit', edit_post_path(@post) %> |
<%= link_to 'Back', posts_path %>

<h2>Comments</h2>
<div id="comments">
        <%= render :partial => @post.comments %>
</div>
```

You'll now need to create a file called `app/views/comments/_comment.html.erb` with the following contents:

```erb
<p id="notice"><%= notice %></p>
             
<%= render :partial => @post %>..

<%= link_to 'Edit', edit_post_path(@post) %> |
<%= link_to 'Back', posts_path %>

<h2>Comments</h2>
<div id="comments">
  <%= render :partial => @post.comments %>
</div>
```

You'll now need to create a file called `app/views/comments/_comment.html.erb` with the following contents:

```erb
<%= div_for comment do %>
  <p>
    <strong>    
      Posted <%= time_ago_in_words(comment.created_at) %> ago
    </strong>
    <br/>       
    <%= comment.body %>
  </p>  
<% end %>
```

Back in `app/views/posts/show.html.erb` you need to add in the form for
submitting a comment so add the following code to the bottom of that
file.

```erb
<%= form_for [@post, Comment.new] do |f| %>
  <p>
    <%= f.label :body, "New comment" %><br/>
    <%= f.text_area :body %>
  </p>  
  <p><%= f.submit "Add comment" %></p>
<% end %>
```
Comments are now working (if they aren't make sure you restart your `rails server`) so go ahead and browse to your post and add a new comment.

Now is a time to save our work

```console
git -A
git commit -m "add comment views"
```

Publishing your Blog on the internet
===

Heroku is a fantastically simple service that can be used to host Ruby
on Rails applications. You'll be able to host your blog on Heroku on
their free-tier but first you'll need a Heroku account. Head to
https://www.heroku.com/, click Sign Up and create an account. The
starter documentation for Heroku is available at:
https://devcenter.heroku.com/articles/quickstart. You've already got an
account so you'll need to download the Toolbelt from
https://toolbelt.heroku.com/ and set it up on your computer.


About databases
===
Up until this point we've been using SQLite as our database, but
unfortunately Heroku doesn't support the use of SQLite. So we're going to be running Postgres instead.
Setting this up is easy you'll need to open the Gemfile and make your Gemfile look like:

```ruby
source 'https://rubygems.org'

gem 'rails', '4.1.4'

gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0',          group: :doc

gem 'spring',        group: :development

group :development, :test do
  gem 'sqlite3'
end

group :production do
  gem 'pg'
end
```

After this run the command  the following command from the terminal:

```console
bundle install --without=production
```

Again it is a good point to save your work with git

```console
git -A
git commit -m "add pg gem to get ready for deployment"
```

Regarding version control
===
Heroku also requires that every application is placed under version. We
have already been saving our project with git so we're covered.

Deploying your application
===

In the same command prompt you should be ready to deploy your
application. First we create our Heroku application. The third word
(blogger) in the following command is optional. The name 'blogger'
may already be taken, so you can call it something like 'bobs-blogger'
or if you don't provide one heroku will create one for you.

```console
heroku create blogger
```
Now we push our application to Heroku:

```console
git push heroku master
```

Finally we setup our database:

```console
heroku run rake db:setup
```

This setup should only need to take place the first time you deploy to heroku. Afterwards you may need to run `db:migrate` instead.

Finally you should be able to browse to the URL that Heroku has given
you and check to see that your blog has been deployed properly!

Or just type:

```console
heroku open
```

Setting the index/root page in Rails

Currently our site only shows the posts if you navigate to /posts. This
is all well and good, but if you go to the "root page" of the website at
http://localhost:3000 you get the "Welcome to Rails" page.

Obviously, if we want people to start reading our blog, it would be good
if we show the blog posts we have immidiately when they come to our
site, without having them navigate elsewhere.

Now, open `config/routes.rb` and add root `:to => 'posts#index'` to tell rails the rails router to take our visitors directly to the list of all posts. So, that file so it looks like:

```ruby
Rails.application.routes.draw do
  root to: 'posts#index'

  resources :posts do
    resources :comments
  end 
end
```

We're effectively telling rails that the route of our app goes to the
'index' action of the 'posts' controller.

### Saving and deploying your changes
At this point you can commit all your changes and git by typing.

```console
git add -A
git commit -m "set root to the list of posts"
```

And then you can deploy to Heroku with `git push heroku master`. Give it a few minutes and you'll be able to navigate to your blog on Heroku now to see the changes you've made.

Getting read of the noise
===

If you take a look at the terminal window from where you launched the
rails server, you'll notice something that looks like this (there is
actually a lot more noise but, it's been abbreviated to not take too
much space on this tutorial):

```console
Started GET "/" for 127.0.0.1 at 2014-07-12 10:16:53 -0500
Processing by PostsController#index as HTML
  Post Load (0.2ms)  SELECT "posts".* FROM "posts"
  Rendered posts/_post.html.erb (0.8ms)
  Rendered posts/index.html.erb within layouts/application (1.9ms)
Completed 200 OK in 8ms (Views: 6.8ms | ActiveRecord: 0.2ms)


Started GET "/assets/comments.css?body=1" for 127.0.0.1 at 2014-07-12
10:16:53 -0500


Started GET "/assets/posts.css?body=1" for 127.0.0.1 at 2014-07-12
10:16:53 -0500


Started GET "/assets/scaffolds.css?body=1" for 127.0.0.1 at 2014-07-12
10:16:53 -0500

...
```

To get rid of so much noise let's install the 'quiet_rails' gem. So,
add the following lines to your `Gemfile`:

```ruby
group :development do
  gem 'quiet_assets'
end
```

This adds this gem to our development group. Now type `bundle install` in your terminal  and restart your `rails server`.

#### quiet_assets gem
You can read more about this gem at https://github.com/evrone/quiet_assets 

#### stopping the server
Remember that to stop your server you type `Ctrl-c`.

Now your server logs we'll look cleaner, something like this:

```console
Started GET "/" for 127.0.0.1 at 2014-07-12 10:27:10 -0500
  ActiveRecord::SchemaMigration Load (0.1ms)  SELECT
"schema_migrations".* FROM "schema_migrations"
Processing by PostsController#index as HTML
  Post Load (0.2ms)  SELECT "posts".* FROM "posts"
  Rendered posts/_post.html.erb (3.9ms)
  Rendered posts/index.html.erb within layouts/application (12.4ms)
Completed 200 OK in 60ms (Views: 45.7ms | ActiveRecord: 0.5ms)
...
```

Let's add and commit our changes:

```console
git add -A
git commit -m "add gem file for cleaner server logs"
```
