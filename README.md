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
  validate :title, :body, presence: true
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
