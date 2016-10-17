class UsersController < ApplicationController

  def new
  end

  def create
  # if params[:user][:password] == params[:user][:password_confirmation]

    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/users/new',
      notice: 'Sign up form did not process... check that all fields are filled in and that your password matches the password confirmation'
    end
  end



private
  def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
