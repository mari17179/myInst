class PostsController < ApplicationController
  def index
    @posts = Post.order(created_at: :desc).limit(15)
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
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
   @post.destroy

   respond_to do |format|
     format.html { redirect_to posts_url }
     format.json { head :no_content }
  end
end

  private

  def post_params
      params.require(:post).permit(:image, :description)
  end
end
