# frozen_string_literal: true

Rails.application.routes.draw do
  resources :profiles
  root 'users#index'

  devise_for :users
  resources :users, except: :create
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
