class Question < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :answers, dependent: :destroy
  has_many :likes, dependent: :destroy
  attachment :image

  validates :title, presence: true, length: {maximum: 40}
  validates :body, presence: true, length: {maximum: 300}

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  def self.sort(keyword)
    case keyword
    when 'new'
      all.order(created_at: :DESC)
    when 'old'
      all.order(created_at: :ASC)
    when 'likes'
      find(Like.group(:question_id).order(Arel.sql('count(question_id) desc')).pluck(:question_id))
    when 'answers'
      find(Answer.group(:question_id).order(Arel.sql('count(question_id) desc')).pluck(:question_id))
    end
  end
end
