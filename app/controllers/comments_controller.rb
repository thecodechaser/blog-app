# frozen_string_literal: true

class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @new_comment = current_user.comments.new(
      text: comment_params,
      author_id: current_user.id,
      post_id: @post.id
    )
    @new_comment.post_id = @post.id
    if @new_comment.save
      redirect_to "/users/#{@post.author_id}/posts/#{@post.id}", flash: { alert: 'Your comment is saved' }
    else
      flash.now[:error] = 'Could not save comment'
      render action: 'new'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)[:text]
  end
end
