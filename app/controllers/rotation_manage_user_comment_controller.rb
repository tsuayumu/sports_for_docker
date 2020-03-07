class RotationManageUserCommentController < ApplicationController
  def create
    rotation_manage = RotationManage.find(params[:rotation_manage_id])
    rotation_manage_user_comment = RotationManageUserComment.create(
      rotation_manage: rotation_manage,
      comment: params[:user_comment]
    )

    render json: { user_comment: rotation_manage_user_comment.comment }
  end
end
