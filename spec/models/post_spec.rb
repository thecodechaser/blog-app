require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Post model' do
    user = User.create(name: 'Ranjeet', bio: 'This is bio')
    subject { Post.new(title: 'post title', text: 'post text', author_id: user) }
    before { subject.save}

    it 'check the title is not blank' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'check if the title is not exceeding 250 characters' do
      subject.title = 'Hello world Hello world Hello world Hello world Hello world Hello world Hello world Hello world
      Hello world Hello world Hello world Hello world Hello world Hello world Hello world Hello world Hello world Hello
      world Hello world Hello world Hello world Hello world Hello world Hello world Hello world Hello world Hello world'
      expect(subject).to_not be_valid
    end

    it 'check if comments counter is numeric' do
      subject.comments_counter = 'not-numeric'
      expect(subject).to_not be_valid
    end

    it 'check if likes counter is numeric' do
      subject.like_counter = 'not-numeric'
      expect(subject).to_not be_valid
    end

    it 'check if likes counter is equal or greater than zero' do
      expect(subject.like_counter).to be >= 0
    end

    it 'check if comments counter is equal or greater than zero' do
      expect(subject.comments_counter).to be >= 0
    end

    it 'loads only the recent 5 comments' do
      expect(subject.recent_comments).to eq(subject.comments.last(5))
    end
  end

end