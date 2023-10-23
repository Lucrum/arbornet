class LikesController < ApplicationController
  before_action :check_existing_like, only: %i[create destroy]
  def create
    return redirect_to request.referrer, notice: "Cannot like again" if @existing_like

    @like = current_user.likes.build(likable_params)

    flash[:notice] = @like.save ? "Liked post" : "Unable to like post"

    redirect_to request.referrer
  end

  def destroy
    return redirect_to request.referrer, notice: "Like does not exist" unless @existing_like
    @like = Like.find(params[:id])

    @like.destroy

    flash[:notice] = "Unliked post"

    redirect_to request.referrer
  end

  # to do likes, comments
  # add guard

  private

  def likable_params
    params.require(:like).permit(:likable_id, :likable_type)
  end

  def check_existing_like
    @existing_like = current_user.likes.find_by(
      likable_id: likable_params[:likable_id],
      likable_type: likable_params[:likable_type]
    ).present?
  end
end
