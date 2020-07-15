class PostsController < ApplicationController
  def index
    @posts = Post.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new

    @comments = @post.comments
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.image.attached? && @post.save
      redirect_to @post, notice: 'Post uploaded successfully'
    else
      redirect_to newpost_path
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to profile_path(@post.user.username)
  end

  def likes
    @post = Post.find(params[:post_id])
    @userslikes = Like.where(post_id: @post.id)
  end

  private

  def post_params
    params.require(:post).permit(:image, :description)
  end
end
