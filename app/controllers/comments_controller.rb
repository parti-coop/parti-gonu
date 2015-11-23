class CommentsController < ApplicationController
  include SlackNotifing

  def create
    @stand = Stand.find(params[:stand_id])
    @stand.touch
    @comment = @stand.comments.build(create_params)
    @comment.user = current_user
    @comment.save

    if @comment.errors.any?
      flash[:error] = @comment.errors.full_messages.to_sentence
    else
      slack(@comment)
    end

    redirect_to @stand.poster
  end

  private

  def create_params
    params.require(:comment).permit(:body)
  end
end
