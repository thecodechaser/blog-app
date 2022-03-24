# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET index' do
    before(:each) { get '/users' }

    it 'Should be 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'should render a template' do
      expect(response).to render_template('users/index')
    end

    it 'should test placeholder text inside template' do
      expect(response.body).to include('Show all users')
    end
  end

  describe 'GET show' do
    before(:each) { get '/users/25' }

    it 'Should be 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'should render a template' do
      expect(response).to render_template('users/show')
    end

    it 'should test placeholder text inside template' do
      expect(response.body).to include('Show users info')
    end
  end
end
