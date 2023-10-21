class NotificationsController < ApplicationController
  def index
    @pending_friend_requests = current_user.received_friend_requests
        .where(status: :pending)
    @sent_friend_requests = current_user.sent_friend_requests
  end
end
