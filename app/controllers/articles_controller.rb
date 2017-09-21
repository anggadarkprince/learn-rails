class ArticlesController < ApplicationController
  http_basic_authenticate_with name: 'angga', password: 'secret', except: [:index, :show]

  def is_authorized
    if session.has_key?('authorized_id')
      @author = User.find(session.fetch(:authorized_id, '0'))
      if @author.nil?
        session.destroy
        redirect_to login_path
        false
      else
        true
      end
    else
      redirect_to login_path
      false
    end
  end

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
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render 'new'
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
    params.require(:article).permit(:title, :content)
  end

end
