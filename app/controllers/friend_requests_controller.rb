class FriendRequestsController < ApplicationController
  # can only send request if there isn't one already
  def create
    target_user = User.find(friend_request_params)

    unless current_user.sent_friend_requests.where(receiver: target_user).any?
      @friend_request = current_user.sent_friend_requests.build(receiver: User.find(friend_request_params))
      @friend_request.status = "pending"


      flash[:notice] = "Unable to send friend request" unless @friend_request.save
    else
      flash[:notice] = "Already sent a request to this user."
    end

    redirect_to request.referrer
  end

  # only receiver can update
  def update
    @friend_request = FriendRequest.find(update_request_params[:id])
    if @friend_request.receiver == current_user && @friend_request.status == "pending"
      case update_request_params[:status]
      when "accept"
        # creates a new friendship between both parties
        @friendship = current_user.inverse_friendships.build(sender: @friend_request.sender)
        if @friendship.save
          @friend_request.destroy
          # destroy all requests
          remove_all_outstanding_requests(current_user, @friend_request.sender)
        else
          flash[:notice] = "Unable to accept friend request"
        end
      when "ignore"
        @friend_request.update(status: :ignored)
      end
    end
    redirect_to request.referrer
  end

  # only sender can destroy
  def destroy
    @request = FriendRequest.find(params[:id])
    if @request.sender == current_user
      @request.destroy
      flash[:notice] = "Request deleted"
    else
      flash[:notice] = "Failed to delete request"
    end

    redirect_to request.referrer
  end

  private

  def remove_all_outstanding_requests(user_one, user_two)
    # get all requests between user one and two, and destroy them, pending OR ignored
    friend_requests = FriendRequest.oustanding(user_one, user_two)
    
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
