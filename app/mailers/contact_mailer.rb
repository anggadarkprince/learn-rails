class ContactMailer < ApplicationMailer
  def contact_email(contact)
    @contact = contact
    email_with_name = '"Angga Ari Wijaya" <anggadarkprince@gmail.com>'
    mail(to: email_with_name, subject: 'Contact: ' + @contact.subject, from: @contact.email, reply_to: @contact.email)
  end
end
