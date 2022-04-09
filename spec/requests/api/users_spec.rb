# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api//v1/users', type: :request do
  path '/api/v1/users/sign_up' do
    # You'll want to customize the parameter types...

    post 'Sign up' do
      tags 'users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[name email password]
      }

      response '201', 'Sign up successfull' do
        let(:user) { { name: 'Tom', email: 'email@example.com', text: '123456' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:user) { { name: 'Tom', email: 'email@example.com', text: '123456' } }
        run_test!
      end
    end
  end

  path '/api/v1/users/sign_in' do
    # You'll want to customize the parameter types...

    post 'Sign in' do
      tags 'users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password]
      }

      response '201', 'Sign in successfull' do
        let(:user) { { email: 'email@example.com', text: '123456' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:user) { { email: 'email@example.com', text: '123456' } }
        run_test!
      end
    end
  end
end
