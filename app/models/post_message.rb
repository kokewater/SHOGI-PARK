class PostMessage < ApplicationRecord
  belongs_to :user

  validates :message, presence: true, length: {maximum: 300}
end
