class BlogController < ApplicationController
  layout 'application'
  before_action :get_category_list, :get_archive_list

  def get_category_list
    @categoriesMenu = Category.all
  end

  def get_archive_list
    @archivesMenu = Article.select('YEAR(created_at) AS year, DATE_FORMAT(created_at, "%m") AS month, DATE_FORMAT(created_at, "%M") AS month_name')
                        .group('year, month, month_name')
  end

  def index
    @articles = Article.order(created_at: :desc).all
  end

  def show
    articleSlug = params[:slug]
    @article = Article.find_by_slug!(articleSlug)
  end

  def category
    categorySlug = params[:slug]
    @category = Category.find_by_slug!(categorySlug)
    @articles = @category.articles.order(created_at: :desc).all
  end

  def tag
    tagSlug = params[:slug]
    @tag = Tag.find_by_slug!(tagSlug)
    @articles = @tag.articles.order(created_at: :desc).all
  end

  def archive
    @year = params[:year]
    @month = params[:month]
    @articles = Article.where('YEAR(created_at) = :year AND DATE_FORMAT(created_at, "%m") = :month', year: "#{@year}", month: "#{@month}")
  end

  def search
    query = params[:q]
    @query = query;
    @articles = Article.where('title LIKE :query', query: "%#{query}%").all
  end
end
