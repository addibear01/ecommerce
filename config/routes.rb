Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'categories/index'
  get 'categories/show'
  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # Routes for categories and teddy types
  get 'categories', to: 'categories#index'
  get 'categories/:id', to: 'categories#show', as: 'category'
  get 'pages/:id', to: 'pages#show', as: 'page'
  
  resources :teddy_types, only: [:index, :show]

  # Root path
  root 'teddy_types#index'
end
