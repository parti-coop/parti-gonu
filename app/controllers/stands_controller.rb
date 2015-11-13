class StandsController < ApplicationController
  def create
    @poster = Poster.find(params[:poster_id])

    @stand = @poster.stands.build(create_params)
    @stand.user = current_user
    @stand.save

    flash[:error] = @stand.errors.full_messages.to_sentence if @stand.errors.any?
    redirect_to @poster
  end

  private

  def create_params
    params.require(:stand).permit(versions_attributes: [:choice, :comment])
  end
end
