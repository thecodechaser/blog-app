# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def current_user
    User.first
  end
end
