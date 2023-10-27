class User < ApplicationRecord
  validates :username, presence: true
  validates :username, length: { minimum: 3 }
  validates :username, uniqueness: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # accepted friendships
  has_many :friendships, foreign_key: 'sender_id'
  has_many :friends, -> { where(friendships: { status: :accepted }) },
    through: :friendships, source: :receiver
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'receiver_id'
  has_many :inverse_friends, -> { where(friendships: { status: :accepted }) },
    through: :inverse_friendships, source: :sender

  # friendship requests
  has_many :sent_friend_requests, -> { where(friendships: { status: :pending })
    .or(where(friendships: { status: :ignored })) },
    class_name: 'Friendship', foreign_key: 'sender_id'
  has_many :received_friend_requests, -> { where(friendships: { status: :pending })
    .or(where(friendships: { status: :ignored })) },
  class_name: 'Friendship', foreign_key: 'receiver_id'

  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :liked_posts, through: :likes,
    source: :likable, source_type: "Post"
  has_many :liked_comments, through: :likes,
    source: :likable, source_type: "Comment"

  has_many :posts, dependent: :destroy

  # avatar
  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end
end
