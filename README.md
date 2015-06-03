## Simple Sinatra Example

This repository holds an example Sinatra app (Fwitter) that students will build together in the first 5-6 weeks of our advanced class. We're going to talk through the different pieces of the application to get a better sense of what it does. Fork, clone and open the repo in Sublime Text (or your text editor of choice).

### Install your dependencies
Before you jump in to the code, head to the root project directory in terminal and run `bundle install` to install the gems you need to run your application.

### Set up your Database
We're using ActiveRecord to create and alter our sqlite3 database. ActiveRecord is a domain specific language that allows us to interact with SQL databases using ruby-like syntax. There's a lot of 'magic' that ActiveRecord gives us, and we'll talk about that in detail later on. To set up our database, we've written migrations (found in db/migrate) that are instructions for the setup of the tables in our database. We run migrations using a rake task. In your project's home directory, run `rake db:migrate`. You should see some messages detailing the creation of tables and columns in your database.

### Spin up Your Local Server
Now, run `shotgun` in your home directory. This deploys your app to a temporary local server, that you can visit on yur web browser by going to `localhost:9393`. Visit this page now to get a sense of what we're building.

#### Now that you've seen what we're building, let's look at the code...

### Your Gemfile
Your Gemfile is the list of gem dependencies that your application has. Open it up and you'll see a bunch of gem names. The gems inside `group :development` are only installed locally for development purposes, while those that are free-floating will be used in development and production of your app. Let's quickly talk about each one:
+ `"sinatra"`: The web applicaiton/dsl library that we're using.
+ `"activerecord"`: A domain specific language allowing for integration of relational databases with ruby.
+ `"sinatra-activerecord"`: Connects Sinatra and ActiveRecord.
+ `"rake"`: Gives us the ability to create and use Rake tasks.
+ `"sqlite3"`: The SQL database we'll be using (in development).
+ `"pry"`: Used to 'pause' and dig in to your code.
+ `"shotgun"`: Library that allows you to run your server locally. Dynamically updates.
+ `"tux"`: Creates a consonle (like irb) with all of your code (i.e. database instances) loaded up.

### The App Directory
#### Models
Take a look at the `user.rb` and `tweet.rb` files in the models directory. Pretty simple, no? The beauty of Sinatra and ActiveRecord is that all of the attributes of your models are inherited through ActiveRecord when you create tables and columns of the same name. If you head to the `db` directory and click on `schema.rb` you'll see we have a `users` table and a `tweets` table, each with various columns. Those columns act as the attributes for our models. For example, the User model has an email reader and writer method because it has that column in the database. It's important to make sure you're inheriting from Activerecord::Base and that the name of the model is the singular form of the similarly named table (the model is `User` and the table is `users`).

#### Views
Views are the html files that are rendered when a user goes to a page in your application. You'll notice that they end in the `.erb` file extension (instead of html). This stands for 'embedded ruby.' Embedded Ruby allows you use the '<% %>' and '<%= %>' tags in your code, which give you the capability to run ruby code within your html. This means we can pull data from the database and inject it (via instance variables from the controller) in to our views dynamically. If you navigate to the users.erb page, you'll see an `@users` variable - we iterate over it (it's an array) to show information on each available user via erb injection.

#### Controllers
Controllers are like the central nervous system of your application. Messages from the browser are sent here via 'requests'. The two main requests we'll be using are 'GET' and 'POST' requests (There are others, but we won't touch on them here.). A 'GET' request generally means the user is asking for a webpage to be displayed on their browser. For each 'GET' request, we have to build a route based on that request. That is, if a user sends a 'get' request to '/users', the server needs to know what to do when that request is made: make an @users variable (with all of the User objects loaded into it) and render the 'user.erb' view. This happens in the route that looks like this:

```ruby
 get '/users' do
    @users = User.all
    erb :users
  end
```
As opposed to 'GET' requests that ask the server for data, 'POST' requests are sending the server data from the user (via a form). This information is passed to the controller via a hash called 'params'. In the params hash, form input 'name' attributes consist of the hash's keys, and the user's input consists of the hash's values. Once the params are received via the "POST" route, the data can be extracted from the params and instances of our models can be created (using ActiveRecord inherited methods). Here's what our POST route to '/sign-up' looks like (which means we have a form whose action attribute is '/sign-up' and method attribute is 'post'):
```ruby
post '/sign-up' do
    @user = User.new(:name => params[:name], :email => params[:email])
    @user.save
    redirect '/tweets'
  end
 ```
When a post request is sent to '/sign-up', a new instance of the User class is created, and it's name and email attributes are set to the values given by the user and passed in through params. Next, the new user is saved to the database. FInally, we redirect the browser  to the '/tweets' route ('GET' request)

This may all seem a little confusing, but once you understand the pattern it will become a lot clearer. In short:

+ Models are the data structures and logic behind your application.
+ Views are the pages that your user will see.
+ Controllers are the ferry between the models and views.

### Other Files and Directories
+ Public: Your public directory contains all of the css, images, and javascript needed for your application.
+ Config: Your config folder contains the environment.rb file, which contains code that helps with the setup of your development environment. This includes setting up the database and requiring the 'bundler' gem that allows you to run `bundle install` and install the gems listed in your Gemfile.
+ config.ru: The config.ru file is the file that is run initially by the server when it is spun up. It requires the application controller file and runs a new instance of the ApplicationController class.
+ Rakefile: Your Rakefile brings in the different rake tasks that are available to you via ActiveRecord. Run `rake -T` in your command line to see the rake tasks that are available to you.


During our bootcamp we'll spend a significant amount of time studying and buidling Sinatra Applications.


