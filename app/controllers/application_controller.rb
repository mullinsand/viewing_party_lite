# frozen_string_literal: true

class ApplicationController < ActionController::Base
  private
  def set_user
    @user = User.find(session[:user_id]) if session[:user_id]
  end
end
