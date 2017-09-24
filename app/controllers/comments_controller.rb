class CommentsController < ApplicationController
  http_basic_authenticate_with name: 'angga', password: 'secret', only: :destroy

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    redirect_to blog_show_path(slug: @article.slug) + '#comment', alert: 'success', notice: 'Your comment was successfully submitted.'
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end

  def vote
    @comment = Comment.find(params[:id])
    if (params[:type] == 'up')
      @comment.votes = @comment.votes + 1
    else
      @comment.votes = @comment.votes - 1
    end
    if @comment.save
      render json: {
          status: 'success',
          code: 200,
          result: {
              id: @comment.id,
              views: @comment.votes
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
  def comment_params
    params.require(:comment).permit(:name, :email, :comment, :type)
  end
end
