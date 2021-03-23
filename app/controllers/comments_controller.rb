class CommentsController < ApplicationController
  before_action :authenticate_user!


  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @commentable
    else
      redirect_to @commentable, alert: "Something went wrong"
    end
  end

  def edit
    authorize @comment
  end

  def update
    authorize @comment
  end

  def destroy
    authorize @comment
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :parent_id)
    end
end
