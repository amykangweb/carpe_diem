class UsersController < ApplicationController
  before_action :set_user_id, only: [:following, :followers, :feed]

  def following
  end

  def followers
  end

  def feed
    @activity = @user.activity.paginate(page: params[:page], per_page: 20)
  end

  def show
    @user = User.find(params[:id])
  end

  private

  # set :user_id for friendships
  def set_user_id
    @user = User.find(params[:user_id])
  end
end
