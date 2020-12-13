class Question < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :answers, dependent: :destroy
  has_many :likes, dependent: :destroy
  attachment :image

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
end
