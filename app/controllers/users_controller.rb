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

    flash[:notice] = "Please enter valid username and password."
    redirect to '/signup'
  end

end