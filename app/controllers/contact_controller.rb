class ContactController < ApplicationController

  def form
  end

  def create
    @contact = Contact.new(params.require(:contact).permit(:name, :email, :subject, :message))

    if @contact.save
      # Tell the UserMailer to send a welcome email after save
      ContactMailer.contact_email(@contact).deliver_later

      redirect_to('/'+I18n.default_locale.to_s+'/contact', notice: 'Message was successfully submitted.')
    else
      render action: 'form'
    end
  end

end
