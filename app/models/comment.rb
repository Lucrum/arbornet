class Comment < ApplicationRecord
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable
  has_many :likes, as: :likable
end
