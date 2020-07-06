class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:id])
    @comment = @blog.comments.create(comment_params)

    if @comment.save
      redirect_to root_path
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
