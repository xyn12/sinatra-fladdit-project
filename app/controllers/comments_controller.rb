class CommentsController < ApplicationController

  get '/comments/:id/new' do
    redirect to '/login' unless logged_in?

    if @post = Post.find_by(id: params[:id])
      erb :'/comments/new_comment'
    else
      flash[:notice] = "Cannot comment on a post that doesn't exist!"
      redirect to '/posts'
    end    
  end

  post '/comments/:id/new' do
    @post = Post.find(params[:id])
    @comment = @post.comments.create(content: params[:content], user: current_user)

    if @comment.valid?
      redirect to "/posts/#{@post.id}"
    end

    flash[:notice] = @comment.errors.full_messages.first
    redirect to "/comments/#{@post.id}/new"
  end

  get '/comments/:id/edit' do
    redirect to '/login' unless logged_in?

    if @comment = Comment.find_by(id: params[:id])
      if @comment.user.id != current_user.id
        flash[:notice] = "You cannot edit another user's comment."
        redirect to "/posts/#{@comment.post.id}"
      end

      erb :'/comments/edit'
    else
      flash[:notice] = "Comment not found."
      redirect to '/posts'
    end  
  end

  patch '/comments/:id/edit' do
    @comment = Comment.find(params[:id])

    if @comment.update(content: params[:content])
      redirect to "/posts/#{@comment.post.id}"
    end

    flash[:notice] = @comment.errors.full_messages.first
    redirect to "/comments/#{@comment.id}/edit"
  end

  delete '/comments/:id/delete' do
    if @comment = Comment.find(params[:id]) 
      @comment.destroy
      redirect to "/posts/#{@comment.post.id}"
    end

    flash[:notice] = @comment.errors.full_messages.first
    redirect to "/comments/#{@comment.id}/edit"
  end
  
end