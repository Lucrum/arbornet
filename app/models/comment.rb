class Comment < ApplicationRecord
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable
  has_many :likes, as: :likable

  validates :content, length: { minimum: 1, message: "Comment is too short" }
  validates :creator, presence: true
  validates :commentable_type, inclusion: { in: %w[Post Comment] }
  validates :commentable_id, presence: true
end
