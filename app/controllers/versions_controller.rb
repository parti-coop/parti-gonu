class VersionsController < ApplicationController
  def create
    @stand = Stand.find(params[:stand_id])
    previous = @stand.current_version

    @version = @stand.versions.create(create_params)
    @version.previous = previous
    @version.save

    flash[:error] = @version.errors.full_messages.to_sentence if @version.errors.any?
    redirect_to @stand.poster
  end

  private

  def create_params
    params.require(:version).permit(:choice, :comment)
  end
end
