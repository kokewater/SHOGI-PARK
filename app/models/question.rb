class Question < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :answers, dependent: :destroy
  has_many :likes, dependent: :destroy
  attachment :image
  
  validates :genre_id, presence: true
  validates :title, presence: true
  validates :body, presence: true

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
end
