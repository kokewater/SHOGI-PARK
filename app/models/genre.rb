class Genre < ApplicationRecord
  has_many :questions

  validates :name, presence: true, length: {maximum: 20}
end
