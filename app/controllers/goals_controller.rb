class GoalsController < ApplicationController
  before_action :set_goal, only: [:incomplete, :completed, :show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:incomplete, :completed, :new, :create, :edit, :update,
    :destroy]
  before_action :check_user, only: [:incomplete, :completed, :edit, :update, :destroy]

  def completed
    @goal.update(completed: true)
    redirect_to :back, notice: "Goal has been marked as completed!"
  end

  def incomplete
    @goal.update(completed: false)
    redirect_to :back, notice: "Goal has been marked as incomplete."
  end

  # GET /goals
  # GET /goals.json
  def index
    @goals = Goal.where(private: false).paginate(page: params[:page],
    per_page: 10)
  end

  # GET /goals/1
  # GET /goals/1.json
  def show
    if @goal.private? && current_user != @goal.user
      redirect_to root_url, alert: "You are not authorized."
    else
      @user = @goal.user
      @entries = @goal.entries.all.paginate(page: params[:page],
      per_page: 10)
    end
  end

  # GET /goals/new
  def new
    @goal = Goal.new
  end

  # GET /goals/1/edit
  def edit
  end

  # POST /goals
  # POST /goals.json
  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id

    respond_to do |format|
      if @goal.save
        format.html { redirect_to @goal, notice: 'Goal was successfully created.' }
        format.json { render :show, status: :created, location: @goal }
      else
        format.html { render :new }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /goals/1
  # PATCH/PUT /goals/1.json
  def update
    respond_to do |format|
      if @goal.update(goal_params)
        format.html { redirect_to @goal, notice: 'Goal was successfully updated.' }
        format.json { render :show, status: :ok, location: @goal }
      else
        format.html { render :edit }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /goals/1
  # DELETE /goals/1.json
  def destroy
    @goal.destroy
    respond_to do |format|
      format.html { redirect_to goals_url, notice: 'Goal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_goal
      @goal = Goal.find(params[:id])
    end

    def check_user
      unless @goal.user == current_user || current_user.admin?
        redirect_to root_url, alert: 'You are not authorized.'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def goal_params
      params.require(:goal).permit(:description, :private, :name, :tag_list, :completed)
    end
end
