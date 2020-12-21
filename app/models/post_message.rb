class PostMessage < ApplicationRecord
  belongs_to :user

  validates :message, presence: true, length: {maximum: 300}

  def obey_1min_role?(user)
    user.post_messages.last(5).first.created_at <= 1.minutes.ago
  end
end