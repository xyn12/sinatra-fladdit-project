class PostsController < ApplicationController

  get '/posts' do
    redirect to '/login' unless logged_in?
    @posts = Post.all.sort { |a, b| b.votes <=> a.votes }

    erb :'/posts/index'
  end

  post '/vote/:id' do
    @post = Post.find(params[:id])

    if params[:action] == "Upvote"
      @post.votes += 1
      @post.save
    elsif params[:action] == "Downvote"
      @post.votes -= 1
      @post.save
    end
    redirect to '/posts'
  end

  get '/posts/new' do
    redirect to '/login' unless logged_in?

    erb :'/posts/new_post'
  end

  post '/posts/new' do
    @post = current_user.posts.create(title: params[:title])

    if @post.valid?
      redirect to "/posts/#{@post.id}"
    end

    flash[:notice] = @post.errors.full_messages.first
    redirect to '/posts/new'
  end

  get '/posts/:id' do
    redirect to '/login' unless logged_in?

    if @post = Post.find_by(id: params[:id])
      erb :'/posts/show'
    else
      flash[:notice] = "Cannot load a post that doesn't exist."
      redirect to '/posts'
    end
  end
  
end