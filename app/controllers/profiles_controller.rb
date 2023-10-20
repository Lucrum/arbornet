class ProfilesController < ApplicationController
  def show
    @profile = User.find_by(username: params[:username])

    @friendships = @profile.friendships
    
    @pending_friend_requests = @profile.received_friend_requests.where(status: "pending")
    @friends = @profile.friendships + @profile.inverse_friendships
    @sent_friend_requests = @profile.sent_friend_requests.where(status: "pending")

    # are they currently friends?
    current_friends = current_user.friends + current_user.inverse_friends

    # does this user have a request sent to them?
    current_sent_requests = current_user.sent_friend_requests.where(receiver: @profile)

    # does this user have a pending request sent from them?
    current_received_requests = current_user.received_friend_requests.where(sender: @profile).where(status: "pending")

    unless (@profile == current_user ||
      (current_friends.include? @profile) ||
      current_sent_requests.any? ||
      current_received_requests.any?)
      @friendable = true
    else
      @friendable = false
    end
  end

  def update
  end
end
