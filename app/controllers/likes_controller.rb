class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    current_user.like(@post)
    redirect_to @post
  end

  def destroy
    @post = Post.find(params[:post_id])
    current_user.dislike(@post)
    redirect_to @post
  end
end
