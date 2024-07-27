Rails.application.routes.draw do
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get "up" => "rails/health#show", as: :rails_health_check

  resources :categories, only: [:index, :show]
  resources :teddy_types, only: [:index, :show]
  resources :pages, only: [:show]
  resources :orders, only: [:index, :show, :new, :create, :destroy] do
    resources :payments, only: [:new, :create]
  end

  get 'about', to: 'pages#about', as: :about
  get 'contact', to: 'pages#contact', as: :contact

  resource :cart, only: [:show] do
    post 'add_item/:teddy_type_id', to: 'cart_items#create', as: 'add_item'
    delete 'remove_item/:id', to: 'cart_items#destroy', as: 'remove_item'
    patch 'update_item/:id', to: 'cart_items#update', as: 'update_item'
  end

  namespace :admin do
    get 'orders_report', to: 'orders_report#index', as: 'orders_report'
  end

  post 'webhooks/stripe', to: 'webhooks#stripe'

  resources :orders do
    member do
    get :new_payment
  end
end

  root 'teddy_types#index'
end
