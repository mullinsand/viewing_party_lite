# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
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
      redirect_to user_path(@user)
    else
      redirect_to register_path(@user)
      flash[:alert] = @user.errors.full_messages.to_sentence
    end
  end

  def login_form

  end

  def login_user
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      redirect_to user_path(user)
    else
      redirect_to login_path(@user)
      flash[:alert] = user ? 'Incorrect password' : 'Invalid Email'
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :email, :password, :password_confirmation)
  end

  def incorrect_email
    flash[:alert] = 'Invalid Email'
  end
end

