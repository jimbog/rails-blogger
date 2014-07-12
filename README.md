== Building the Application

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
If you type the ```ls -1pa``` you can see all the file that have been
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

Open your web-brower and head to: http://localhost:3000 and you should
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
