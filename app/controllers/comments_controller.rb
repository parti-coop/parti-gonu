class CommentsController < ApplicationController
  def create
    @stand = Stand.find(params[:stand_id])
    @stand.touch
    @comment = @stand.comments.build(create_params)
    @comment.user = current_user
    @comment.save

    flash[:error] = @comment.errors.full_messages.to_sentence if @comment.errors.any?

    redirect_to @stand.poster
  end

  private

  def create_params
    params.require(:comment).permit(:body)
  end
end
