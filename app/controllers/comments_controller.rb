class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update,
    :destroy]
  before_action :check_user, only: [:edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
    @goal = Goal.find(params[:goal_id])
    @entry = Entry.find(params[:entry_id])
  end

  # POST /comments
  # POST /comments.json
  def create
    @entry = Entry.find(params[:entry_id])
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.entry_id = @entry.id

    respond_to do |format|
      if @comment.save
        format.html { redirect_to :back, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { redirect_to :back, alert: @comment.errors.full_messages.to_sentence }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    @goal = Goal.find(params[:goal_id])
    @entry = Entry.find(params[:entry_id])
      if @comment.update(comment_params)
        redirect_to goal_entry_path(@goal, @entry),
        notice: 'Comment was successfully updated.'
      else
        render :edit,
        alert: 'Comment was not updated.'
      end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def check_user
      unless @comment.user == current_user || current_user.admin?
        redirect_to root_url, alert: 'You are not authorized.'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:body)
    end
end
