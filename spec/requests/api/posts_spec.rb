# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/posts', type: :request do
  path '/api/v1/posts' do
    # You'll want to customize the parameter types...
    parameter name: 'X-AUTH-TOKEN', in: :header, type: :string

    get('list posts') do
      tags 'posts'
      consumes 'application/json'

      response(200, 'successful') do
        let(:'X-AUTH-TOKEN') { '123' }
        run_test!
      end

      response(422, 'Invalid request') do
        let(:'X-AUTH-TOKEN') { '123' }
        run_test!
      end
    end
  end

  path '/api/v1/posts/create' do
    # You'll want to customize the parameter types...
    parameter name: 'X-AUTH-TOKEN', in: :header, type: :string

    post 'Create a post' do
      tags 'posts'
      consumes 'application/json'
      parameter name: :post, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          text: { type: :string }
        },
        required: %w[title text]
      }

      response '201', 'post created' do
        let(:'X-AUTH-TOKEN') { '123' }
        let(:post) { { title: 'foo', text: 'bar' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:'X-AUTH-TOKEN') { '123' }
        let(:post) { { title: 'foo', text: 'bar' } }
        run_test!
      end
    end
  end
end
