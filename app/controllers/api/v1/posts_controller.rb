# frozen_string_literal: true

module Api
  module V1
    class PostsController < ApplicationController
      def index
        if request.headers['X-AUTH-TOKEN']
          @user = User.find_by_api_token(request.headers['X-AUTH-TOKEN'])
          if @user
          @posts = Post.where(author_id: @user.id)
          render json: { success: true, message: 'Loaded all posts', data: { posts: @posts } }, status: :ok
        else 
          render json: { success: false, errors: 'Wrong authentication token' }, status: :unprocessable_entity
        end
        else
          respond_to do |format|
            format.json { render json: 'please sign in or add the token', status: :ok }
          end
        end
      end

      def create
        if request.headers['X-AUTH-TOKEN']
          @user = User.find_by_api_token(request.headers['X-AUTH-TOKEN'])
          new_post = @user.posts.new(title: params[:title], text: params[:text])
          if new_post.save
            render json: { success: true, message: 'Post created', data: { post: new_post } }, status: :created
          else
            render json: { success: false, errors: new_post.errors }, status: :unprocessable_entity
          end
        else
          respond_to do |format|
            format.json { render json: 'please sign in or add the token', status: :ok }
          end
        end
      end
    end
  end
end
