class PostsController < ApplicationController
  before_action :set_post, except: %i[index new create]
  before_action :check_post_ownership, except: %i[index new create show]

  def index
    @posts = Post.all.includes([:creator, :likes])
  end

  def new
    @post = Post.new
  end

  def show
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post, notice: "Post created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    unless @post.creator == current_user
      redirect_to root_path
    end
  end

  def update
    redirect_to root_path unless @post.creator == current_user

    if @post.update(post_params)
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
    params.require(:post).permit(:content)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def check_post_ownership
    return redirect_to root_path unless @post.creator == current_user
  end
end
