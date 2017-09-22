class AuthController < ApplicationController

  def login_form
    if session.has_key?('is_authorized')
      redirect_to articles_path
    else
      @user = User.new
      render 'auth/login'
    end
  end

  def login
    username = params[:user][:username]
    @user = User.where(username: username).or(User.where(email: username)).take
    if !@user.nil?
      password = params[:user][:password]
      begin
        if (@user.hash_password == password)
          session[:is_authorized] = true
          session[:authorized_id] = @user.id
          session[:authorized_username] = @user.username
          session[:authorized_role] = @user.role
          redirect_to articles_path
        else
          @user = User.new(username: username)
          @user.errors.add(:password, 'Your password is wrong')
          flash.now[:alert] = 'warning'
          flash.now[:notice] = 'Login attempting failed'
          render 'auth/login'
        end
      rescue BCrypt::Errors::InvalidHash
        flash[:alert] = 'danger'
        flash[:notice] = 'Your password seems invalid, please reset your credential to re-establish your password.'
        redirect_to action: :login_form
      end
    else
      flash[:alert] = 'danger'
      flash[:notice] = 'User account is not found.'
      redirect_to action: :login_form
    end
  end

  def logout
    session.destroy
    redirect_to root_path
  end

  def register_form
    if session.has_key?('is_authorized')
      redirect_to articles_path
    else
      @user = User.new
      render 'auth/register'
    end
  end

  def register
    @user = User.new(register_params)
    @user.avatar = 'noavatar.jpg'

    if @user.save
      redirect_to login_form_path, alert: 'success', notice: 'User was successfully registered.'
    else
      render 'auth/register', alert: 'danger', notice: 'Something went wrong.'
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
