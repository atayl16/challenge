Rails.application.routes.draw do
  devise_for :users
  resources :projects, path: :challenges
  resources :users, only: [:index]

  get 'home/index'
  root 'home#index'
end
