require 'swagger_helper'

RSpec.describe 'api/v1/comments', type: :request do
  path '/api/v1/posts/{post_id}/comments' do
    # You'll want to customize the parameter types...
    parameter name: 'post_id', in: :path, type: :integer, description: 'post_id'

    get('list comments') do
      response(200, 'successful') do
        let(:post_id) { '123' }

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

    post 'Create a comment' do
      tags 'Comments'
      consumes 'application/json'
      parameter name: :comment, in: :body, schema: {
        type: :object,
        properties: {
          text: { type: :string }
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
