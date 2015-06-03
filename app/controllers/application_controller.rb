require './config/environment'
require'pry'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get'/' do
    erb :index
  end

  get '/tweets' do
    @tweets = Tweet.all
    @users = User.all
    erb :tweets
  end

  post '/tweets' do
    if params[:user_id]
      tweet = Tweet.new(:user_id => params[:user_id], :status => params[:status])
      tweet.save
      redirect '/tweets'
    else
      "Invalid Input"
    end
  end

  get '/users' do
    @users = User.all
    erb :users
  end

  post '/sign-up' do
    @user = User.new(:name => params[:name], :email => params[:email])
    @user.save
    redirect '/tweets'
  end
end