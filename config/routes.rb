# frozen_string_literal: true

Rails.application.routes.draw do
  get 'promotion_codes/update'
  resources :order_details, only: %i[index show]
  post 'orders/create'
  resources :carts, only: %i[show]
  post '/add_item', to: 'carts#create'
  delete '/destroy', to: 'carts#destroy'
  namespace :admin do
    resources :products, only: %i[index create new edit update destroy]
  end
  root to: 'products#index'
  resources :products
  resources :tasks
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
