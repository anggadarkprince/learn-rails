module ApplicationHelper

  def random_string
    SecureRandom.urlsafe_base64
  end

  def is_authorized(object = nil)
    if object.nil?
      !session[:is_authorized].nil? && !session[:authorized_id].nil?
    else
      if object.try(:user_id)
        object.user_id == session[:authorized_id]
      elsif object.try(:id)
          object.id == session[:authorized_id]
      end
    end
  end

end
