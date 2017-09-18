class BlogController < ApplicationController
  layout 'application'

  def index
    @articles = Article.all
  end

  def show
    articleSlug = params[:slug]
    @article = Article.find_by_slug(articleSlug)
  end

  def category
    categoryId = params[:id]
    @category = Category.find(categoryId);
    @articles = @category.articles
  end

  def tag
    @articles = Article.all
  end

  def archive
    @articles = Article.all
  end
end
