class ProfilesController < ApplicationController
  def show
    @profile = User.find_by(username: params[:username])
    
    @friendships = @profile.friendships.where(status: :accepted)
      .or(@profile.inverse_friendships.where(status: :accepted))

    @friendable = user_friendable? @profile

    if @profile == current_user
      @pending_friend_requests = current_user.received_friend_requests
        .where(status: :pending)
      @sent_friend_requests = current_user.sent_friend_requests
    end
  end

  def update
  end

  private

  def user_friendable?(target_user)
    # are they currently friends?
    current_friends = current_user.friends + current_user.inverse_friends

    # does this user have a request sent to them?
    current_requests = Friendship.outstanding(current_user, target_user)
      .where(status: :pending)

    unless (target_user == current_user ||
      (current_friends.include? target_user) ||
      current_requests.any?)
      @friendable = true
    else
      @friendable = false
    end
  end
end
