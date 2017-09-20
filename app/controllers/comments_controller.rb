class CommentsController < ApplicationController
  http_basic_authenticate_with name: 'angga', password: 'secret', only: :destroy

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    redirect_to blog_show_path(slug: @article.slug), notice: 'Your comment was successfully submitted.'
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end

  private
  def comment_params
    params.require(:comment).permit(:name, :email, :comment)
  end
end
