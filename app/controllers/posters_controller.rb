class PostersController < ApplicationController
  def index
    @posters = Poster.all
  end

  def new
    @poster = Poster.new
  end

  def show
    @poster = Poster.find(params[:id])
    if params[:auth].present?
      session[:user_return_to] = poster_path(@poster)
      redirect_to new_user_session_path and return
    end

    @current_user_stand = ((user_signed_in? and @poster.has_stand_of?(current_user)) ?
      @poster.stand_of(current_user) : @poster.stands.build)
    @persisted_stands = @poster.stands.reject(&:new_record?)
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
