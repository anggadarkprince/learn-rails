class BlogController < ApplicationController
  layout 'application'

  def index
    @articles = Article.all
  end

  def show
    articleSlug = params[:slug]
    @books = Article.find_by('slug', articleSlug)
  end

  def category
    categoryId = params[:id]
    @books = Article.find_by('category_id', categoryId)
  end

  def tag
    @books = Article.all
  end

  def archive
    @books = Article.all
  end
end
