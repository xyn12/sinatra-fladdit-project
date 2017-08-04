class PostsController < ApplicationController

  get '/posts' do
    redirect to '/login' unless logged_in?

    erb :'/posts/index'
  end
  
end