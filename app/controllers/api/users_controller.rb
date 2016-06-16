class Api::UsersController < ApplicationController
  def show
    user = User.find_by_username(params[:id])
    goals = user.goals.where(private: false)
    render json: goals.each.as_json(include:[:entries])
  end
end
