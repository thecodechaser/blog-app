# frozen_string_literal: true

class CommentsController < ApplicationController
  # load_and_authorize_resource

  def create
    @post = Post.find(params[:post_id])
    @new_comment = current_user.comments.new(
      text: comment_params,
      author_id: current_user.id,
      post_id: @post.id
    )
    if @new_comment.save
      redirect_to "/users/#{@post.author_id}/posts/#{@post.id}", flash: { alert: 'Your comment is saved' }
    else
      flash.now[:error] = 'Could not save comment'
      render action: 'new'
    end
  end

  def destroy
    @comment = Comment.find(params[:comment_id])
    post = Post.find_by(id: @comment.post_id)
    post.comments_counter -= 1
    @comment.destroy!
    post.save
    flash[:success] = 'You have deleted this comment!'
    redirect_to user_post_path(post.author_id, post.id)
  end

  private

  def comment_params
    params.require(:comment).permit(:text)[:text]
  end
end
