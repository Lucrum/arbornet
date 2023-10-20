class FriendshipsController < ApplicationController
  # can only send request if there isn't one already
  def create
    target_user = User.find(friend_request_params)

    unless current_user.sent_friend_requests.where(receiver: target_user).any?
      @friendship = current_user.sent_friend_requests.build(receiver: User.find(friend_request_params), status: :pending)

      flash[:notice] = 'Unable to send friend request' unless @friendship.save
    else
      flash[:notice] = 'Already sent a request to this user.'
    end

    redirect_to request.referrer
  end

  # only receiver can update
  def update
    @friendship = Friendship.find(update_request_params[:id])
    if @friendship.receiver == current_user && @friendship.status == 'pending'
      case update_request_params[:status]
      when 'accept'
        if @friendship.update(status: :accepted)
        # destroy any oustanding requests
          remove_all_outstanding_requests(current_user, @friendship.sender)
          flash[:notice] = "Accepted friend request"
        else
          flash[:notice] = "Failed to accept request."
        end
      when 'ignore'
        if @friendship.update(status: :ignored)
          flash[:notice] = "Ignored user"
        else
          flash[:notice] = "Failed to ignore user"
        end
      end
    end
    redirect_to request.referrer
  end

  # only sender can destroy pending
  # todo people who users have ignored can still send requests to them
  # friend requests don't show up
  # ONLY THE LOGGED IN USER CAN DESTROY THEIR OWN FRIENDSHIPS
  def destroy
    target_friendship = Friendship.find(params[:id])
    target_friendship.destroy

    flash[:notice] = 'Friend removed.'
    redirect_to request.referrer
  end

  private

  # removes all duplicate requests that are either pending or ignored
  def remove_all_outstanding_requests(user_one, user_two)
    # get all requests between user one and two, and destroy them, pending OR ignored
    friend_requests = Friendship.outstanding(user_one, user_two)
      .where(status: %i[pending ignored])
    
    friend_requests.each do |req|
      req.destroy
    end
  end

  def friend_request_params
    params.require(:receiver)
  end

  def update_request_params
    params.permit(:id, :status, :_method)
  end

  
end
