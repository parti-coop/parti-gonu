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

    has_stand = (user_signed_in? and @poster.has_stand_of?(current_user))
    @current_user_stand = (has_stand ? @poster.stand_of(current_user) : @poster.stands.build)
    @persisted_stands = @poster.stands.latest.reject(&:new_record?)
    @persisted_in_favor_stands = @persisted_stands.select(&:in_favor?)
    @persisted_oppose_stands = @persisted_stands.select(&:oppose?)
  end

  def create
    @poster = Poster.new(create_params)
    @poster.user = current_user
    @poster.save!

    redirect_to @poster
  end

  private

  def create_params
    params.require(:poster).permit(:url, relatings_attributes: [ :relating_id ] )
  end
end
