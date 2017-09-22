class AccountController < ApplicationController

  def settings_form
    if is_authorized
      @user = User.find(session[:authorized_id])
      render 'account/settings'
    end
  end

  def settings
    if is_authorized
      @user = User.find(session[:authorized_id])

      if @user.update(settings_params)
        flash[:alert] = 'success'
        flash[:notice] = 'Account settings was successfully updated.'
        redirect_to action: :settings_form
      else
        flash.now[:alert] = 'danger'
        flash.now[:notice] = 'Something went wrong, try again or contact our support.'
        render 'account/settings'
      end
    end
  end

  private
  def settings_params
    params.require(:user).permit(:name, :username, :email, :about, :current_password, :new_password, :new_password_confirmation)
  end

end
