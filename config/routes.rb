Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "posts#index"

  resources :posts do
    get "like", to: "likes#like"
    resources :comments
  end

  resources :comments do
    get "like", to: "likes#like"
    resources :comments
  end

  resources :profiles, only: %i[index show edit update], param: :username

  resources :friendships, only: %i[create update destroy]
  resources :notifications, only: %i[index]
end
