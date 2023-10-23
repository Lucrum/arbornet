class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likable, polymorphic: true

  validates :user, presence: true

  validates :likable_type, presence: true
  # ensure only posts and comments are liked on
  validates :likable_type, inclusion: { in: %w[Post Comment] }

  validates :likable_id, presence: true
end
