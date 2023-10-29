class Post < ApplicationRecord
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likable, dependent: :destroy

  has_many_attached :photos do |attachable|
    attachable.variant :medium, resize_to_limit: [250, 250]
    attachable.variant :large, resize_to_limit: [500, 500]
  end

  validate :has_text_or_photo
  validate :text_size

  def has_text_or_photo
    unless content? || photos.attached?
      errors.add(:post, "must have either text or a photo")
    end
  end

  def text_size
    if content? && content.length > 500
      errors.add(:text, "cannot be too long (500 character limit)")
    end
  end
end
