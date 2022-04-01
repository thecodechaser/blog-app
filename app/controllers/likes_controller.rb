# frozen_string_literal: true

class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    new_like = current_user.likes.new(
      author_id: current_user.id,
      post_id: @post.id
    )
    if new_like.save
      redirect_to "/users/#{@post.author_id}/posts/#{@post.id}", flash: { alert: 'Your like is saved' }
    else
      redirect_to "/users/#{@post.author_id}/posts/#{@post.id}", flash.now[:error] = 'Could not save like'
    end
  end
end
