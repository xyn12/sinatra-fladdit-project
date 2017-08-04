class UsersController < ApplicationController

  get '/signup' do
    redirect to '/posts' if logged_in?

    erb :'/users/signup'
  end

  post '/signup' do
    @user = User.create(username: params[:username], password: params[:password])

    if @user.valid?
      session[:user_id] = @user.id
      redirect to '/posts'
    end

    flash[:notice] = @user.errors.full_messages.first
    redirect to '/signup'
  end

  get '/login' do
    redirect to '/posts' if logged_in?

    erb :'/users/login'
  end

  post '/login' do
    if @user = User.find_by(username: params[:username]).try(:authenticate, params[:password])
      session[:user_id] = @user.id
      redirect to '/posts'
    end

    flash[:notice] = "Please enter valid username and password."
    redirect to '/login'
  end

end