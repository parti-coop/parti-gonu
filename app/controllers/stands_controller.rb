class StandsController < ApplicationController
  include SlackNotifing

  def show
    @stand = Stand.find params[:id]
    @poster = @stand.poster

    if !user_signed_in? or !@poster.has_stand_of? current_user
      redirect_to @poster and return
    end
  end

  def edit
    @stand = Stand.find(params[:id])
  end

  def oppose
  end

  def create
    @poster = Poster.find(params[:poster_id])
    @stand = @poster.stands.build(create_params)
    @stand.user = current_user

    @stand.save

    if @stand.errors.any?
      flash[:error] = @stand.errors.full_messages.to_sentence
    else
      slack(@stand)
    end
    redirect_to @stand.poster
  end

  def update
    @stand = Stand.find(params[:id])
    previous = @stand.current_version

    version_params = update_params[:versions_attributes]['0']
    unless previous.same? version_params
      @stand.assign_attributes(update_params)
      @stand.touch
      @version = @stand.versions.last
      @version.previous = previous
    end

    @stand.save

    errors = []
    errors << @stand.errors.full_messages.to_sentence if @stand.errors.any?
    errors << @version.errors.full_messages.to_sentence if @version.present? and @version.errors.any?
    flash[:error] = errors.join

    unless errors.any?
      slack(@stand)
    end

    redirect_to @stand.poster
  end

  private

  def create_params
    params.require(:stand).permit(versions_attributes: [:choice, :reason])
  end

  def update_params
    params.require(:stand).permit(versions_attributes: [:choice, :reason])
  end
end
