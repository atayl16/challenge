Rails.application.routes.draw do
  resources :enrollments
  devise_for :users
  resources :users, only: [:index, :edit, :show, :update]
  get "dashboard", to: "users#dashboard"
  get 'home/index'
  root 'home#index'
  resources :projects, path: :challenges do
    resources :enrollments, only: [:new, :create]
    get :accepted, :pending_review, :created, on: :collection
  end
end
