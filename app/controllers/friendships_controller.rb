class FriendshipsController < ApplicationController
  def destroy
    target_friendship = Friendship.find(params[:id])
    target_friendship.destroy

    flash[:notice] = "Friend removed."
    redirect_to request.referrer
  end
end
