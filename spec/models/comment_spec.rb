# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'Comment model' do
    user = User.new(name: 'Tom', photo: 'Tom.png', bio: 'bio', posts_counter: 0)
    post = Post.new(title: 'New post', text: 'Good evening', author: user, like_counter: 0, comments_counter: 0)
    post.save!

    comment_creator = User.new(name: 'Jerry', photo: 'Tom.png', bio: 'bio', posts_counter: 0)
    post.comments.create!(text: 'Hello World', author: comment_creator)
    post.comments.create!(text: 'This is my second post', author: comment_creator)

    it 'add some comments' do
      expect(post.comments.length).to eql(2)
    end
  end
end
