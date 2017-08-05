class PostsController < ApplicationController

  get '/posts' do
    redirect to '/login' unless logged_in?
    @posts = Post.all

    erb :'/posts/index'
  end
  
end