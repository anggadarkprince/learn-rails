class AuthController < ApplicationController

  def login_form
    @user = User.new
    render 'auth/login'
  end

  def login
    username = params[:user][:username]
    password = params[:user][:password]
    @user = User.find_by_username(username)
    if (!@user.nil?)
      if (@user.password == password)
        redirect_to root_path
      else
        @user = User.new(username: username)
        @user.errors.add(:password, 'Your password is wrong')
        render 'auth/login'
      end
    else
      @user = User.new(username: username)
      @user.errors.add(:username, 'User account is not found')
      render 'auth/login'
    end
  end

  def register_form
    @user = User.new
    render 'auth/register'
  end

  def register
    @user = User.new(register_params)
    @user.avatar = 'noavatar.jpg'

    if @user.save
      redirect_to login_form_path, alert: 'success', notice: 'User was successfully registered.'
    else
      render 'register_form', alert: 'danger', notice: 'Something went wrong.'
    end
  end

  private
  def login_params
    params.require(:user).permit(:username, :password)
  end

  private
  def register_params
    params.require(:user).permit(:name, :username, :email, :password, :password_confirmation, :terms_of_service)
  end

end
