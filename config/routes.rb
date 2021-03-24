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
  resources :projects do
    member do
      put "like" => "projects#like"
      put "complete" => "projects#complete"
    end
  end
  resources :enrollments do
    member do
      put "complete" => "enrollment#complete"
    end
    get :incomplete, on: :collection
    member do
      patch :complete
      patch :uncomplete
    end
  end
end
