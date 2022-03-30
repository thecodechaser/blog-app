# frozen_string_literal: true

class UsersController < ApplicationController
  def index;
  # @users = User.all.order(created_at: :desc)
  @user = current_user
  end

  def show; end
end
