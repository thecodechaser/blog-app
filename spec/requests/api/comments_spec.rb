# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/comments', type: :request do
  path '/api/v1/comments' do
    # You'll want to customize the parameter types...
    parameter name: 'X-Token', in: :header, type: :string

    get('list comments') do
      tags 'Comments'
      response(200, 'successful') do
        let(:'X-Token') { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response('422', 'Invalid request') do
        let(:'X-Token') { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/comments/create' do
    # You'll want to customize the parameter types...
    parameter name: 'X-Token', in: :header, type: :string

    post 'Create a comment' do
      tags 'Comments'
      consumes 'application/json'
      parameter name: :comment, in: :body, schema: {
        type: :object,
        properties: {
          text: { type: :string },
          post_id: { type: :number }
        },
        required: ['text']
      }

      response '201', 'comment created' do
        let(:comment) { { text: 'foo' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:comment) { { text: 'foo' } }
        run_test!
      end
    end
  end
end
