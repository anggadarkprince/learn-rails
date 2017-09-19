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
    @articles = Article.where('YEAR(created_at) = :year AND DATE_FORMAT(created_at, "%m") = :month', year: "#{@year}", month: "#{@month}").page params[:page]
  end

  def search
    query = params[:q]
    @query = query;
    @articles = Article.where('title LIKE :query', query: "%#{query}%").page params[:page]
  end
  
end
