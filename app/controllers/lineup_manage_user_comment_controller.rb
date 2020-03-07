class LineupManageUserCommentController < ApplicationController
  def create
    lineup_manage = LineupManage.find(params[:lineup_manage_id])
    lineup_manage_user_comment = LineupManageUserComment.create(
      lineup_manage: lineup_manage,
      comment: params[:user_comment]
    )

    render json: { user_comment: lineup_manage_user_comment.comment }
  end
end
