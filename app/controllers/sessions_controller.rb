class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email].downcase)

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      user.role == 'admin' ? (redirect_to admin_dashboard_path) : (redirect_to dashboard_path)
    else
      redirect_to login_path(@user)
      flash[:alert] = user ? 'Incorrect password' : 'Invalid Email'
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end
end