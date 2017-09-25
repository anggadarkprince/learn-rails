class CommentsController < ApplicationController

  def create
    @article = Article.find(params[:article_id])
    params = comment_params
    if is_authorized
      author = User.find(session.fetch(:authorized_id, '0'))
      params[:name] = author.name
      params[:email] = author.email
      params[:user_id] = author.id
    end

    if @article.comments.create(params)
      flash[:alert] = 'success'
      flash[:notice] = 'Your comment was successfully submitted.'
    else
      flash[:alert] = 'danger'
      flash[:notice] = 'Comment failed to submit, please try again.'
    end
    redirect_back(fallback_location: root_path, anchor: '#comment')
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    if @comment.destroy
      flash[:alert] = 'success'
      flash[:notice] = 'The comment was successfully deleted.'
    else
      flash[:alert] = 'danger'
      flash[:notice] = 'Comment failed to delete, please try again.'
    end
    redirect_back(fallback_location: root_path)
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
    params.require(:comment).permit(:name, :email, :comment, :comment_id, :type)
  end
end
