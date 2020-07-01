class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all.where("id != ?", current_user.id)
    @common_friends = current_user.friends
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @mutual = @user.friends & current_user.friends
  end

  def accept
    @user = User.find(params[:user_id])
    current_user.confirm_friend(@user)
    redirect_to users_path
  end


  def reject
    @user = User.find(params[:user_id])
    current_user.decline_friend(@user)
    redirect_to users_path
  end

  def invite
    @friendship = Friendship.new(user_id: current_user.id, friend_id: params[:friend_id])
    @friendship.save
    redirect_to users_path
  end

  def remove
    @friendship = current_user.friendships.find_by(user_id: current_user.id, friend_id: params[:user_id])
    @friendship.destroy
    redirect_to users_path
  end
end
