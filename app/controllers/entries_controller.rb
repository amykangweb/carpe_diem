class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :uncheer, :cheer, :edit, :update, :destroy]
  before_action :set_goal
  before_action :authenticate_user!, only: [:cheer, :uncheer, :new, :create, :edit, :update,
    :destroy]
  before_action :check_user, only: [:edit, :update, :destroy]
  before_action :entry_goal_user?, only: [:new, :create]
  before_action :set_cheerers, only: [:cheer, :uncheer, :show]
  before_action :previous_entry, only: [:show]
  before_action :next_entry, only: [:show]

  def cheer
    @cheered = @entry.cheers.create(user_id: current_user.id)

    if @cheered.save
      respond_to do |format|
        flash.now[:notice] = "Thank you for cheering!"
        format.js { render 'cheer' }
      end
    else
      flash.now[:alert] = "You have already cheered this."
      redirect_to :back
    end
  end

  def uncheer
    Cheer.destroy_all(entry_id: @entry.id, user_id: current_user.id)

    respond_to do |format|
      flash.now[:alert] = "You have uncheered this entry."
      format.js { render 'cheer' }
    end
  end

  # GET /entries
  # GET /entries.json
  def index
    @entries = Entry.all
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
    @comment = Comment.new
    @comments = @entry.comments.paginate(page: params[:page], per_page: 10)
  end

  # GET /entries/new
  def new
    @entry = Entry.new
  end

  # GET /entries/1/edit
  def edit
  end

  # POST /entries
  # POST /entries.json
  def create
    @entry = Entry.new(entry_params)
    @entry.goal_id = @goal.id
    @entry.user_id = current_user.id

    respond_to do |format|
      if @entry.save
        format.html { redirect_to @goal, notice: 'Entry was successfully created.' }
        format.json { render :show, status: :created, location: @entry }
      else
        format.html { render :new }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entries/1
  # PATCH/PUT /entries/1.json
  def update
    respond_to do |format|
      if @entry.update(entry_params)
        format.html { redirect_to :back, notice: 'Entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @entry }
      else
        format.html { render :edit }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry.destroy
    respond_to do |format|
      format.html { redirect_to @goal, notice: 'Entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # returns next entry
    def next_entry
      @next = @goal.entries.select { |obj| obj.id > @entry.id }.last
    end
    # returns previous entry
    def previous_entry
      @previous = @goal.entries.select { |obj| obj.id < @entry.id }.first
    end
    # return array of entry cheerers
    def set_cheerers
      @cheerers = @entry.cheering_users.limit(10)
    end
    # set goal id for entries
    def set_goal
      @goal = Goal.find(params[:goal_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    def entry_goal_user?
      unless @goal.user == current_user
        redirect_to root_url, alert: 'You are not authorized.'
      end
    end

    def check_user
      unless @entry.user == current_user || current_user.admin?
        redirect_to root_url, alert: 'You are not authorized.'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params.require(:entry).permit(:content)
    end
end
