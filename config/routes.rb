Rails.application.routes.draw do
  resources :enrollments
  devise_for :users
  resources :users, only: [:index, :edit, :show, :update]
  get "dashboard", to: "users#dashboard"
  get 'home/index'
  root 'home#index'
  get 'invitations/update'
  get 'invitations/create'
  get 'invitations/destroy'
  resources :projects, path: :challenges do
    resources :enrollments, only: [:new, :create, :edit]
    get :accepted, :pending_review, :created, on: :collection
    resources :comments, module: :projects
  end

  resources :comments do
    resources :comments
  end
end
