class User < ApplicationRecord
  before_save { self.email.downcase! } # データを保存する前にemailの文字を全て小文字に変換
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false } # 大文字小文字を区別せず同じものと判断
  has_secure_password
  
  has_many :microposts
  has_many :relationships # user.relationshipsとした時はそのuserのフォローしているrelationshipインスタンス全てを取得しに行く
  has_many :followings, through: :relationships, source: :follow
         # user.reverses_of_relationshipとした時はそのuserがフォローされているrelationshipインスタンスを全て取得しに行く
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: :follow_id
  has_many :followers, through: :reverses_of_relationship, source: :user
  has_many :favorites # user.favoritesとした時は自分のuser_idと合致するfavoriteインスタンスを取得しにいく
  has_many :favorite_microposts, through: :favorites, source: :micropost
  
  # ここでのselfは実行したUserのインスタンスを意味する
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end
  
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end
  
  def following?(other_user)
    self.followings.include?(other_user)  
  end
  
  def feed_microposts
    Micropost.where(user_id: self.following_ids + [self.id])
  end
  
  # お気に入りに追加するメソッド
  def favorite(other_micropost)
    self.favorites.find_or_create_by(micropost_id: other_micropost.id)
  end
  # お気に入りを外すメソッド
  def unfavorite(other_micropost)
    favorite = self.favorites.find_by(micropost_id: other_micropost.id)
    favorite.destroy if favorite
  end
  # お気に入り済みか確認するメソッド
  def favorite?(other_micropost)
    self.favorite_microposts.include?(other_micropost)
  end
end
