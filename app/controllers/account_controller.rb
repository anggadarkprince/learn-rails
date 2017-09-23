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

      uploaded_io = params[:user][:avatar]
      filename = uploaded_io.original_filename
      File.open(Rails.root.join('public/images', 'avatars', filename), 'wb') do |file|
        file.write(uploaded_io.read)
        params[:user][:avatar] = filename
      end

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
    params.require(:user).permit(:name, :username, :email, :about, :avatar, :current_password, :new_password, :new_password_confirmation)
  end

end
