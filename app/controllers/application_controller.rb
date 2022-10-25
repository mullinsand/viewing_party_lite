# frozen_string_literal: true

class ApplicationController < ActionController::Base
  private
  def set_user
    @user = User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    @user.present?
  end

  def login_needed_for(page)
    flash[:alert] = "You must be logged in to access the #{page}"
    redirect_back(fallback_location: root_path)
  end

  def authorized
    unauthorized unless @user.role == "admin"
  end

  def unauthorized
    flash[:alert] = 'You are not authorized to access these pages'
    redirect_back(fallback_location: root_path)
  end
end
