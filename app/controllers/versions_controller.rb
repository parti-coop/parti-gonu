class VersionsController < ApplicationController
  def create
    @stand = Stand.find(params[:stand_id])
    previous = @stand.current_version

    if previous.choice == params[:version][:choice]
      @version = previous
      @comment = @version.comments.build(create_params[:comments_attributes]['0'])
    else
      @version = @stand.versions.create(create_params)
      @version.previous = previous
      @comment = @version.comments.first
    end
    @version.save
    flash[:error] = @version.errors.full_messages.to_sentence if @version.errors.any?
    redirect_to @stand.poster
  end

  private

  def create_params
    params.require(:version).permit(:choice, comments_attributes: [:body])
  end
end
