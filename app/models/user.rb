class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  attachment :profile_image
  has_many :likes, dependent: :destroy
  has_many :post_messages, dependent: :destroy

  # ====================自分がフォローしているユーザーとの関連 ===================================

  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id

  has_many :followings, through: :active_relationships, source: :follower
  # ========================================================================================

  # ====================自分がフォローされるユーザーとの関連 ===================================

  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id

  has_many :followers, through: :passive_relationships, source: :following
  # =======================================================================================

  
  validates :name, presence: true
  
  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end

  # 退会済みユーザーを弾く
  def active_for_authentication?
    super && (self.is_deleted == false)
  end

  def self.guest
    find_or_create_by!(name: 'guest',email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end
end