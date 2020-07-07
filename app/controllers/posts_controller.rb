class PostsController < ApplicationController
  def index
    @posts = Post.order(created_at: :desc).limit(15)
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
    if @post.save
      redirect_to @post, notice: "Image uploaded successfully"
    else
      render :new
    end
  end

  def destroy
   @post = Post.find(params[:id])
   @comments = @post.comments.where(post_id: @post.id)
   @comments.each do |comment|
     comment.destroy
   end
   @post.destroy
   redirect_to  profile_path(@post.user.username)
  end

  private

  def post_params
      params.require(:post).permit(:image, :description)
  end
end
