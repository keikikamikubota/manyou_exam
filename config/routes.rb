Rails.application.routes.draw do
  root 'tasks#index'
  resources :sessions, only: [:new, :create, :destroy]
  namespace :admin do
    resources :users
  end
  resources :users, only: [:new, :create, :show, :edit, :update]
  resources :tasks
end