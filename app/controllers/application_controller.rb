# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def current_user
    User.limit(1)
  end
end
