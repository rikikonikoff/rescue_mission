class User < ApplicationRecord
  has_many :questions
  has_many :answers
  has_many :questions, through: :answers

  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: { scope: :provider }
  validates :username, presence: true
  validates :email, presence: true
  validates :avatar_url, presence: true

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.email = auth["info"]["email"]
      user.avatar_url = auth["info"]["image"]
    end
  end
end
