class BlogController < ApplicationController
  layout 'application'

  def index
    @articles = Article.order(created_at: :desc).page params[:page]
  end

  def show
    articleSlug = params[:slug]
    @article = Article.find_by_slug!(articleSlug)
  end

  def category
    categorySlug = params[:slug]
    @category = Category.find_by_slug!(categorySlug)
    @articles = @category.articles.order(created_at: :desc).page params[:page]
  end

  def tag
    tagSlug = params[:slug]
    @tag = Tag.find_by_slug!(tagSlug)
    @articles = @tag.articles.order(created_at: :desc).page params[:page]
  end

  def archive
    @year = params[:year]
    @month = params[:month]
    @articles = Article.where('YEAR(created_at) = :year', year: "#{@year}")
                    .where('DATE_FORMAT(created_at, "%m") = :month', month: "#{@month}")
                    .page params[:page]
  end

  def trending
    @articles = Article.where(created_at: (Time.now.midnight - 1.month)..Time.now.midnight)
                    .order(views: :desc)
                    .take(10)
  end

  def search
    query = params[:q]
    @query = query;
    @articles = Article.select('articles.*').joins(:user)
                    .where('title LIKE :query OR content LIKE :query OR users.name LIKE :query', query: "%#{query}%")
                    .page params[:page]
  end

end
