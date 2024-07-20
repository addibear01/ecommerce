Rails.application.routes.draw do
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get "up" => "rails/health#show", as: :rails_health_check

  resources :categories, only: [:index, :show]
  resources :teddy_types, only: [:index, :show]
  resources :pages, only: [:show]

  resources :carts, only: [:show] do
    post 'add_item/:teddy_type_id', to: 'carts#add_item', as: 'add_item'
    delete 'remove_item/:teddy_type_id', to: 'carts#remove_item', as: 'remove_item'
    patch 'update_item/:cart_item_id', to: 'carts#update_item', as: 'update_item'
  end

  root 'teddy_types#index'
end
