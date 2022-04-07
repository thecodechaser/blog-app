module Api
  module V1
    class PostsController < ApplicationController
      def index
        if request.headers['X-AUTH-TOKEN']
          @user = User.find_by_api_token(request.headers['X-AUTH-TOKEN'])
          @posts = Post.where(author_id: @user.id)
          render json: { success: true, message: 'Loaded all posts', data: { posts: @posts } }, status: :ok
        else
          respond_to do |format|
            format.json { render json: 'please sign in or add the token', status: :ok }
          end
        end
      end
    end
  end
end