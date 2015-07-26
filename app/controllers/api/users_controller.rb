class Api::UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    goals = user.goals.where(private: false)
    render json: goals
  end
end
