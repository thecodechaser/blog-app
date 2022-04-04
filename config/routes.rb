Rails.application.routes.draw do
  devise_for :users
  # root 'users#index'
  # get 'users/745', to: 'users#show'
  # get 'users/745/posts', to: 'posts#index'
  # get 'users/745/posts/3', to: 'posts#show'

  resources :users, only: [:show, :index] do
    resources :posts, only: [:show, :index, :create, :new] do
      resources :comments, only: [:create, :new]
      resources :likes, only: [:create]
      end
   end

end
