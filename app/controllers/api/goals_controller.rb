iclass Api::GoalsController < ApplicationController
  def index
    render json: Goal.all
  end

  def show
    goal = Goal.find(params[:id])
    if goal.private?
      render status: 422, json: {
        message: "Could not retrieve goal.",
      }.to_json
    else
      render json: goal.as_json(include:[:entries])
    end
  end
end
