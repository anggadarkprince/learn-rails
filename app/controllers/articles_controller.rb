class ArticlesController < ApplicationController
  #http_basic_authenticate_with name: 'angga', password: 'secret', except: [:index, :show]

  def index
    if is_authorized
      articleData = @author.articles
      if params[:order_by] == 'popularity'
        articleData = articleData.order(views: :desc)
      else
        articleData = articleData.order(created_at: :desc)
      end
      @articles = articleData.page params[:page]
      render 'author/profile'
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

  def edit
    @article = Article.find(params[:id])
  end

  def create
    if is_authorized
      uploaded_io = params[:article][:featured]
      if !uploaded_io.nil?
        filename = uploaded_io.original_filename
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
        flash[:notice] = 'Post settings was successfully created.'
        redirect_to action: :index
      else
        flash.now[:alert] = 'danger'
        flash.now[:notice] = 'Something went wrong, try again or contact our support.'
        render 'new'
      end
    end
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  private
  def article_params
    params.require(:article).permit(:title, :slug, :content, :featured, :status, :user_id, :all_tags, :category_id)
  end

end
