class CommentsController < ApplicationController

  get '/comments/:id/new' do
    redirect to '/login' unless logged_in?
    @post = Post.find(params[:id])

    erb :'/comments/new_comment'    
  end

  post '/comments/:id/new' do
    @post = Post.find(params[:id])
    @comment = @post.comments.create(content: params[:content], user: current_user)

    if @comment.valid?
      redirect to "/posts/#{@post.id}"
    end

    flash[:notice] = @comment.errors.full_message.first
    redirect to "/comments/#{@post.id}/new"
  end
  
end