class UsersController < ApplicationController
  def show
    @user = User.find_by(username: params[:username])
    @posts = @user.posts.order(created_at: :desc).limit(15)
  end

  def followers
    @user = User.find_by(username: params[:username])
    @followers = Follow.where(following_id: @user.id)
  end

  def followings
    @user = User.find_by(username: params[:username])
    @followings = Follow.where(follower_id: @user.id)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    if @user.destroy
        redirect_to root_url, notice: "User deleted."
    end
  end

end
