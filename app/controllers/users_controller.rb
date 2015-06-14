class UsersController < ApplicationController

  def feed
    @user = User.find(params[:user_id])
  end

  def show
    @user = User.find(params[:id])
  end
end
