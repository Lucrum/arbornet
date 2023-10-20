class User < ApplicationRecord
  validates :username, presence: true
  validates :username, length: { minimum: 3 }
  validates :username, uniqueness: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :friendships, foreign_key: 'sender_id'
  has_many :friends, through: :friendships, source: :receiver
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'receiver_id'
  has_many :inverse_friends, through: :inverse_friendships, source: :sender

  has_many :sent_friend_requests, class_name: 'FriendRequest', foreign_key: 'sender_id'
  has_many :received_friend_requests, class_name: 'FriendRequest', foreign_key: 'receiver_id'

  has_many :posts
end
