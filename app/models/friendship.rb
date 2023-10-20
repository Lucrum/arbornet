class Friendship < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  validates :status, inclusion: { in: %w[accepted pending ignored] }

  scope :accepted, -> { where(status: "accepted") }

  scope :not_accepted, -> { where.not(status: "accepted") }

  scope :outstanding, ->(user_one, user_two) {
    not_accepted.where(sender: user_one, receiver: user_two)
    .or(not_accepted.where(sender: user_two, receiver: user_one))
  }

  scope :active_friendship_between, ->(user_one, user_two) {
    accepted.where(sender: user_one, receiver: user_two)
    .or(accepted.where(sender: user_two, receiver: user_one))
  }
end
