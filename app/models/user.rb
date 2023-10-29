class User < ApplicationRecord
  validates :username, presence: true
  validates :username, length: { minimum: 3 }
  validates :username, uniqueness: true

  validates :email, presence: true
  validates :password, presence: true
  validates :password, length: { minimum: 6 }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]

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
    attachable.variant :medium, resize_to_limit: [250, 250]
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    # Uncomment the section below if you want users to be created if they don't exist
    unless user
      user = User.create(
        username: data['name'],
        email: data['email'],
        password: Devise.friendly_token[0,20],
      )
    end
    user
  end
end
