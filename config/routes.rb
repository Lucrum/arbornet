Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "posts#index"

  resources :users
  resources :posts
  resources :profiles, only: %i[show update], param: :username
  resources :friend_requests, only: %i[create update destroy]
  resources :friendships, only: %i[destroy]
end
