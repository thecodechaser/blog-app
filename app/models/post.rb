# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes
  after_save :update_posts_counter

  validates :title, presence: true, length: { in: 1..250 }
  validates :comments_counter, numericality: { greater_than_or_equal_to: 0 }
  validates :like_counter, numericality: { greater_than_or_equal_to: 0 }

  def recent_comments
    comments.limit(5).order(created_at: :desc)
  end

  private

  def update_posts_counter
    author.increment!(:posts_counter)
  end
end
