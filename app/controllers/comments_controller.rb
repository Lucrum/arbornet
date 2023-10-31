class CommentsController < ApplicationController
  before_action :set_commentable_params
  before_action :set_comment_by_id, only: %i[show edit update destroy]
  before_action :check_comment_ownership, only: %i[edit update destroy]

  # show all comments on a particular commentable
  # todo reverse comment order
  def index # need commentable type and commentable ID
    @comments = Comment.where(commentable_type: @commentable_type)
  end

  def new # possibly commentable type and commentable ID
    @comment = current_user.comments.build(commentable_type: @commentable_type,
      commentable_id: @commentable_id)
  end

  def create # need commentable type and commentable ID
    @comment = current_user.comments.build(comment_params)
    @commentable_object = @commentable_type.singularize.classify.constantize.find(@commentable_id)

    respond_to do |format|
      if @comment.save
        format.turbo_stream
      else
        format.html {
          flash[:errors] = @comment.errors.full_messages
          redirect_to request.referrrer
        }
      end
    end
  end

  # show a specific comment (in isolation?? probably not)
  def show # ID
  end

  def edit # user's only, ID
  end

  def update # user's only, ID
    if @comment.update(comment_params)
      redirect_to polymorphic_path(
        @comment.commentable_type.tableize.singularize,
        id: @comment.commentable_id
      )
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy # user's only, ID
    @comment.destroy
    redirect_to request.referrer, notice: "Comment deleted"
  end

  private

  def set_commentable_params
    if params[:post_id]
      @commentable_type = "Post"
      @commentable_id = params[:post_id]
    elsif params[:comment_id]
      @commentable_type = "Comment"
      @commentable_id = params[:comment_id]
    end
  end

  def comment_params
    params.require(:comment).permit(:content, :commentable_id, :commentable_type)
  end

  def set_comment_by_id
    @comment = Comment.find(params[:id])
  end

  def check_comment_ownership
    return redirect_to root_path unless @comment.creator == current_user
  end

  def set_user_comment
    @comment = current_user.comments.find_by(

      commentable_id: @commentable_id,
      commentable_type: @commentable_type
    )
  end
end
