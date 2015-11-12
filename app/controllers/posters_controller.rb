class PostersController < ApplicationController
  def index
  end

  def new
    @poster = Poster.new
  end

  def show
    @poster = Poster.find(params[:id])
  end

  def create
    @poster = Poster.new(create_params)
    @poster.user = current_user
    @poster.save!
    redirect_to @poster
  end

  private

  def create_params
    params.require(:poster).permit([:url])
  end
end
