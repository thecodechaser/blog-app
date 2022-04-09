Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users
  # get 'users/745', to: 'users#show'
  # get 'users/745/posts', to: 'posts#index'
  # get 'users/745/posts/3', to: 'posts#show'

  # api routes

  namespace :api , defaults: { format: :json } do
    namespace :v1 do
      post 'users/sign_up' => 'users#register'
      post 'users/sign_in' => 'users#login'
      get 'posts' => 'posts#index'
      post 'posts/create' => 'posts#create'
      get 'comments' => 'comments#index'
      post 'comments/create' => 'comments#create'
    end
  end


  # routes for application

  resources :users, only: [:show, :index] do
    resources :posts, only: [:show, :index, :create, :new, :destroy] do
      resources :comments, only: [:create, :new, :destroy]
      resources :likes, only: [:create]
      end
   end

   root 'users#index'

end
