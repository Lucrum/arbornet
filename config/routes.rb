Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

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
