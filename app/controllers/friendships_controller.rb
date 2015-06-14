class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    @friendship.save
    flash[:notice] = 'Successfully followed user.'
    redirect_to :back
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
    flash[:notice] = 'Successfully unfollowed user.'
    redirect_to :back
  end
end
