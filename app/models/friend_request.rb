class FriendRequest < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  scope :oustanding, ->(user_one, user_two) {
    where(sender: user_one).where(receiver: user_two)
    .or(where(sender: user_two).where(receiver: user_one))
  }
end
