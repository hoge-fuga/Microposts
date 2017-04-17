class Micropost < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 255 }
  
  has_many :favorites
  has_many :favorite_users, through: :favorites, source: :user
  
  def favorite(user)
      self.favorites.find_or_create_by(user_id: user.id)
  end

  def unfavorite(user)
    favorite = self.favorites.find_by(user_id: user.id)
    favorite.destroy if favorite
  end
  
  def favorite?(user)
    self.favorite_users.include?(user)
  end
end