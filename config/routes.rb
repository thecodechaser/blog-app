Rails.application.routes.draw do
  root 'users#index'

  get 'users/745', to: 'users#show'

  get 'users/745/posts', to: 'posts#index'

  get 'users/745/posts/3', to: 'posts#show'
end
