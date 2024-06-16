# frozen_string_literal: true

Rails.application.routes.draw do
  resources :carts, only: %i[show]
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
