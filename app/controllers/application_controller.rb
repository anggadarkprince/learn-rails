class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :get_category_list

  def get_category_list
    @categoriesMenu = Category.all
  end

end
