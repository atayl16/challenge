Rails.application.routes.draw do
  devise_for :users
  resources :projects, path: :challenges
  resources :users, only: [:index, :edit, :show, :update]
  get 'home/index'
  root 'home#index'
end
