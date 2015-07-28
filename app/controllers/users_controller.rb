class UsersController < ApplicationController
  before_action :set_user_id, only: [:accomplished, :following, :followers, :feed]

  def accomplished
    if current_user == @user
      @goals = @user.goals.where(completed: true).paginate(page: params[:page], per_page: 20)
    else
      @goals = @user.goals.where(completed: true).where(private: false).paginate(page: params[:page], per_page: 20)
    end
  end

  def following
  end

  def followers
  end

  def feed
    @activity = @user.activity.paginate(page: params[:page], per_page: 20)
  end

  def show
    @user = User.find_by_username(params[:id])
    @goals = @user.goals.paginate(page: params[:page], per_page: 20)
  end

  private

  # set :user_id for friendships
  def set_user_id
    @user = User.find_by_username(params[:user_id])
  end
end
