class LikesController < ApplicationController
  before_action :set_likable_params, only: %i[like]
  before_action :check_existing_like, only: %i[like]

  def like
    if @existing_like
      # remove like
      @existing_like.destroy
      # flash[:notice] = "Unliked #{@likable_type}"
    else
      # add like
      @like = current_user.likes.build(likable_id: @likable_id, likable_type: @likable_type)
      @like.save
      # flash[:notice] = @like.save ? "Liked #{@likable_type}" : "Unable to like #{@likable_type}"
    end


    respond_to do |format|
      format.turbo_stream do
        likable_object = @likable_type.singularize.classify.constantize.find(@likable_id)
        render turbo_stream: turbo_stream.update(
          "#{@likable_type}_#{@likable_id}",
          partial: "likes/like_count",
          locals: { likable: likable_object }
        )
      end
      format.html { redirect_to request.referrer }
    end
  end

  private

  def set_likable_params
    if params[:post_id]
      @likable_type = "Post"
      @likable_id = params[:post_id]
    elsif params[:comment_id]
      @likable_type = "Comment"
      @likable_id = params[:comment_id]
    end
  end

  # only checks for current user's like
  def check_existing_like
    @existing_like = current_user.likes.find_by(
      likable_id: @likable_id,
      likable_type: @likable_type
    )
  end
end
