class LineupManageLikeController < ApplicationController
  def update
    lineup_manage = LineupManage.find(params[:lineup_manage_id])
    lineup_manage.like!

    render json: { like: lineup_manage.like_count }
  end
end
