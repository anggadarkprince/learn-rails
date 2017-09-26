class ContactController < ApplicationController

  def form
  end

  # POST /contact
  # POST /contact.json
  def create
    @contact = Contact.new(params.require(:contact).permit(:name, :email, :subject, :message))

    respond_to do |format|
      if @contact.save
        # Tell the ContactMailer to send a welcome email after save
        ContactMailer.contact_email(@contact).deliver_later

        format.html {
          redirect_to('/'+I18n.default_locale.to_s+'/contact', alert: 'success', notice: 'Message was successfully submitted.')
        }
        format.js {render 'form', locals: {alert: 'success', notice: 'Message was successfully submitted.'}} #default behaviour is to run app/views/contact/create.js.erb file
        format.json {
          render json: @contact, status: :created, location: @contact
        }
      else
        error = @contact.errors.any? ? @contact.errors.full_messages[0] : 'Message failed to submit.'
        format.html {
          flash.now[:alert] = 'danger'
          flash.now[:notice] = error
          render action: 'form'
        }
        format.js {render 'form', locals: {alert: 'danger', notice: error}}
        format.json {
          render json: @contact.errors, status: :unprocessable_entity
        }
      end
    end
  end

end
