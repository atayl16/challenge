Rails.application.routes.draw do
  resources :projects, path: :challenges

  get 'home/index'
  root 'home#index'
end
