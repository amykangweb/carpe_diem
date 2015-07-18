class Api::GoalsController < ApplicationController
  def index
    render json: Goal.all
  end

  def show
    goal = Goal.find(params[:id])
    render json: goal
  end
end
