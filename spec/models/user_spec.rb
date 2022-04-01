
require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'User model' do
    subject { User.new(name: 'Ranjeet', photo: 'ranjeet.png', bio: 'Software programmer', posts_counter: 0) }
    before { subject.save}

    it 'check the name is not blank' do
      subject.name = nil 
      expect(subject).to_not be_valid
    end

    it 'check if posts counter is numeric' do
      subject.posts_counter = 'not-numeric'
      expect(subject).to_not be_valid
    end

    it 'check if posts counter is equal or greater than zero' do
      expect(subject.posts_counter).to be >= 0
    end
  end

  describe 'Validate Recent posts method' do
    before do
      4.times do |post|
        Post.create(author_id: subject, title: "It is a post #{post}", text: 'This is text')
      end
    end

    it 'shows three recent posts' do
      expect(subject.recent_posts).to eq(subject.posts.last(3))
    end
  end

end