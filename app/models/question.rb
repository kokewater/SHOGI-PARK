class Question < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :answers, dependent: :destroy
  attachment :image
end
