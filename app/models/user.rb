class User < ApplicationRecord
  before_save { self.email.downcase! } # データを保存する前にemailの文字を全て小文字に変換
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false } # 大文字小文字を区別せず同じものと判断
  has_secure_password
end
