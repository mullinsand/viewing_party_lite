class Admin::AdminController < ApplicationController
  before_action :set_user, only: %i[show]
  before_action :authorized
  # before_action :require_user

  def show
    login_needed_for('dashboard') unless logged_in?
    @users = User.all
  end

end
