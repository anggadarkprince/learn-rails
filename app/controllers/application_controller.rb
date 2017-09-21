class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :get_category_list, :get_archive_list, :set_locale, :check_logged_user

  def check_logged_user
    if session.has_key?('authorized_id')
      @loggedUser = User.find(session.fetch(:authorized_id, '0'))
    end
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def get_category_list
    @categoriesMenu = Category.all
  end

  def get_archive_list
    @archivesMenu = Article.select('YEAR(created_at) AS year, DATE_FORMAT(created_at, "%m") AS month, DATE_FORMAT(created_at, "%M") AS month_name')
                        .group('year, month, month_name')
  end

end
