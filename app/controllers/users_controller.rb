class UsersController < ApplicationController
  before_action :set_user, only: %i[show]
  # before_action :require_user

  def show
    login_needed_for('dashboard') unless logged_in?
  end

  def new
    @user = User.new
  end

  def create
    user = user_params
    user[:email] = user[:email].downcase
    @user = User.new(user)
    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path(@user)
    else
      redirect_to register_path(@user)
      flash[:alert] = @user.errors.full_messages.to_sentence
    end
  end

  def login_form

  end

  private

  def user_params
    params.require(:user).permit(:user_name, :email, :password, :password_confirmation)
  end
end

