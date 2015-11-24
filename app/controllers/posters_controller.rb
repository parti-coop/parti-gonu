class PostersController < ApplicationController
  include SlackNotifing

  def index
    @posters = Poster.sorted_by_updown.all
    @posters = @posters.tag(params[:tag]) if params[:tag].present?
  end

  def new
    @poster = Poster.new
    if params[:source_id].present?
      @source = Source.find params[:source_id]
    end
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
    @persisted_abstain_stands = @persisted_stands.select(&:abstain?)
  end

  def create
    @poster = Poster.new(create_params)
    unless @poster.source.present?
      @poster.source = Source.find_or_initialize_by(url: @poster.url) do |s|
        s.url = @poster.url
      end
    end
    @poster.user = current_user
    @poster.save

    if @poster.errors.any?
      flash[:error] = @poster.errors.full_messages.to_sentence
      redirect_to :back and return
    else
      slack(@poster)
      redirect_to @poster
    end
  end

  def up
    @poster = Poster.find(params[:id])
    @poster.up_count += 1
    @poster.save!
    redirect_to root_path
  end

  def down
    @poster = Poster.find(params[:id])
    @poster.down_count += 1
    @poster.save!
    redirect_to root_path
  end
  private

  def create_params
    params.require(:poster).permit(:source_id, :url, :tags, :question, relatings_attributes: [ :relating_id ] )
  end
end
