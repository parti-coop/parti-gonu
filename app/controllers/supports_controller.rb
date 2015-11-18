class SupportsController < ApplicationController
  def create
    @target = Stand.find params[:target_id]
    @poster = @target.poster
    unless @poster.has_stand_of?(current_user)
      flash[:error] = "#{current_user.email}의 입장이 없습니다."
      redirect_to @poster and return
    end

    @stand = @poster.stand_of(current_user)
    @support = @stand.supports.build(target: @target)
    @stand.save!

    @target.touch
    @target.save!

    redirect_to @poster
  end

  def destroy
    @support = Support.find params[:id]
    @stand = @support.stand
    @target = @support.target

    @stand.supports.destroy @support
    @stand.save!

    @target.touch
    @target.save!

    @poster = @target.poster
    redirect_to @poster
  end

end
