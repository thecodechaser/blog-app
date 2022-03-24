# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET index' do
    before(:each) { get '/users/:user_id/posts' }

    it 'Should be 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'should render a template' do
      expect(response).to render_template('posts/index')
    end

    it 'should test placeholder text inside template' do
      expect(response.body).to include('Show all posts of a user')
    end
  end

  describe 'GET show' do
    before(:each) { get '/users/:user_id/posts/60' }

    it 'Should be 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'should render a template' do
      expect(response).to render_template('posts/show')
    end

    it 'should test placeholder text inside template' do
      expect(response.body).to include('Show post info')
    end
  end
end
