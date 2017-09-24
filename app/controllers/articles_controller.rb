class ArticlesController < ApplicationController

  def index
    if is_authorized
      article_data = @author.articles
      if params[:order_by] == 'popularity'
        article_data = article_data.order(views: :desc)
      else
        article_data = article_data.order(created_at: :desc)
      end
      @articles = article_data.page params[:page]
      @author = @author
    end
  end

  def show
    if is_authorized
      @article = Article.find(params[:id])
    end
  end

  def new
    if is_authorized
      @article = Article.new
    end
  end

  def create
    if is_authorized
      uploaded_io = params[:article][:featured]
      if !uploaded_io.nil?
        filename = Time.now.strftime('%Y-%m-%d_%H%M%S') + '_' + uploaded_io.original_filename
        File.open(Rails.root.join('public/images', 'features', filename), 'wb') do |file|
          file.write(uploaded_io.read)
          params[:article][:featured] = filename
        end
      else
        params[:article][:featured] = 'no-feature.jpg'
      end
      params[:article][:user_id] = @author.id

      @article = Article.new(article_params)

      if @article.save
        flash[:alert] = 'success'
        flash[:notice] = 'Article was successfully created.'
        redirect_to action: :index
      else
        flash.now[:alert] = 'danger'
        flash.now[:notice] = 'Something went wrong, try again or contact our support.'
        render 'new'
      end
    end
  end

  def edit
    if is_authorized
      @article = Article.find(params[:id])
    end
  end

  def update
    if is_authorized
      uploaded_io = params[:article][:featured]
      unless uploaded_io.nil?
        filename = Time.now.strftime('%Y-%m-%d_%H%M%S') + '_' + uploaded_io.original_filename
        File.open(Rails.root.join('public/images', 'features', filename), 'wb') do |file|
          file.write(uploaded_io.read)
          params[:article][:featured] = filename
        end
      end

      @article = Article.find(params[:id])
      @article.article_tags.destroy

      if @article.update(article_params)
        flash[:alert] = 'success'
        flash[:notice] = 'Article was successfully updated.'
        redirect_to action: :index
      else
        flash.now[:alert] = 'danger'
        flash.now[:notice] = 'Something went wrong, try again or contact our support.'
        render 'edit'
      end
    end
  end

  def destroy
    if is_authorized
      @article = Article.find(params[:id])

      if @article.destroy
        flash[:alert] = 'warning'
        flash[:notice] = 'Article was successfully deleted.'
      else
        flash[:alert] = 'danger'
        flash[:notice] = 'Something went wrong, try again or contact our support.'
      end

      redirect_to articles_path
    end
  end

  def counter
    @article = Article.find(params[:id])
    @article.views = @article.views + 1
    if @article.save
      render json: {
          status: 'success',
          code: 200,
          result: {
              id: @article.id,
              views: @article.views
          }
      }
    else
      render json: {
          status: 'failed',
          code: 500,
          message: 'Internal server error'
      }
    end
  end

  private
  def article_params
    params.require(:article).permit(:title, :slug, :content, :featured, :status, :user_id, :all_tags, :category_id)
  end

end
