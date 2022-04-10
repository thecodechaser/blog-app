# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/comments', type: :request do
  path '/api/v1/comments' do
    # You'll want to customize the parameter types...
    parameter name: 'X-AUTH-TOKEN', in: :header, type: :string

    get('list comments') do
      tags 'Comments'
      consumes 'application/json'

      response(200, 'successful') do
        let(:'X-AUTH-TOKEN') { '123' }
        run_test!
      end

      response('422', 'Invalid request') do
        let(:'X-AUTH-TOKEN') { '123' }
        run_test!
      end
    end
  end

  path '/api/v1/comments/create' do
    # You'll want to customize the parameter types...
    parameter name: 'X-AUTH-TOKEN', in: :header, type: :string

    post 'Create a comment' do
      tags 'Comments'
      consumes 'application/json'
      parameter name: :comment, in: :body, schema: {
        type: :object,
        properties: {
          text: { type: :string },
          post_id: { type: :number }
        },
        required: %w[text post_id]
      }

      response '201', 'comment created' do
        let(:'X-AUTH-TOKEN') { '123' }
        let(:comment) { { text: 'foo', post_id: 0} }
        run_test!
      end

      response '422', 'invalid request' do
        let(:'X-AUTH-TOKEN') { '123' }
        let(:comment) { { text: 'foo', post_id: 0 } }
        run_test!
      end
    end
  end
end
