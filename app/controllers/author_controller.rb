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
    @authors = User.select('users.*, COUNT(articles.id) AS total_article')
                   .joins(:articles)
                   .group('users.id')
                   .order('total_article DESC')
                   .first(5)
    @onTheWeekAuthors = User.select('users.*, SUM(articles.views) AS total_view')
                            .joins(:articles)
                            .where('articles.created_at': (Time.now.midnight - 1.week)..Time.now.midnight)
                            .group('users.id')
                            .order('total_view DESC')
                            .first(8)
  end

end
