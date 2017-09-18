class BlogController < ApplicationController
  layout 'application'

  def index
    @articles = Article.order(created_at: :desc).all
  end

  def show
    articleSlug = params[:slug]
    @article = Article.find_by_slug!(articleSlug)
  end

  def category
    categoryId = params[:id]
    @category = Category.find(categoryId);
    @articles = @category.articles.order(created_at: :desc)
  end

  def tag
    @articles = Article.all
  end

  def archive
    @articles = Article.all
  end

  def search
    query = params[:q]
    @query = query;
    @articles = Article.where('title LIKE :query', query: "%#{query}%").all
  end
end
