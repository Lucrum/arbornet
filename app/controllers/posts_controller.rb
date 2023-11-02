class PostsController < ApplicationController
  before_action :set_post, only: %i[edit update destroy]
  before_action :check_post_ownership, only: %i[edit update destroy]

  # timeline, only show posts from the user and user's friends
  # loads ALL posts, should paginate this
  def index
    total_friends = current_user.friends + current_user.inverse_friends + [current_user]
    @posts = Post.where(creator: total_friends).includes([:creator, :likes, :photos_attachments]).limit(25)
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.includes(:comments).find(params[:id])
  end

  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.turbo_stream
      else
        format.html {
          flash[:errors] = @post.errors.full_messages
          render :new, status: :unprocessable_entity
        }
      end
    end
  end

  def edit
    unless @post.creator == current_user
      redirect_to root_path
    end
  end

  def update
    redirect_to root_path unless @post.creator == current_user

    if @post.update(post_edit_params)
      redirect_to @post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy

    redirect_to root_path, notice: "Post deleted"
  end

  private

  def post_params
    params.require(:post).permit(:content, photos: [])
  end

  def post_edit_params
    params.require(:post).permit(:content)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def check_post_ownership
    return redirect_to root_path unless @post.creator == current_user
  end
end
