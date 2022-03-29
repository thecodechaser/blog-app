class User < ApplicationRecord
  has_many :posts
  has_many :comments
  has_many :likes

  def recent_posts
    posts.limit(3).order(created_at: :desc)
  end

end