class AuthorController < ApplicationController

  def profile
    @author = User.find_by_username!(params[:username])
    articleData = @author.articles
    if(params[:order_by] == 'popularity')
      articleData = articleData.order(views: :desc)
    else
      articleData = articleData.order(created_at: :desc)
    end
    @articles = articleData.page params[:page]
  end

  def top
  end

end
