class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, dependent: :destroy
  has_many :active_followers, class_name: 'Follower', foreign_key: 'follower_id', dependent: :destroy
  has_many :passive_followers, class_name: 'Follower', foreign_key: 'followed_id', dependent: :destroy

  has_many :following, through: :active_followers, source: :followed
  has_many :followers, through: :passive_followers, source: :follower

  def follow(other)
    active_followers.create(followed_id: other.id)
  end

  def unfollow(other)
    active_followers.find_by(followed_id: other.id).destroy
  end

  def following?(other)
    following.include?(other)
  end
end
