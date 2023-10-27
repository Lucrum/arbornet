class Post < ApplicationRecord
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likable, dependent: :destroy

  has_many_attached :photos do |attachable|
    attachable.variant :medium, resize_to_limit: [250, 250]
    attachable.variant :large, resize_to_limit: [500, 500]
  end

  validate :has_text_or_photo

  def has_text_or_photo
    unless content? || photos.attached?
      errors.add(:content, "must have either text or a photo")
    end
  end
end
