Rails.application.routes.draw do

  namespace :user do
    resources :roles
  end

  namespace :user do
    resources :groups
  end

  # Root redirect
  root to: 'root#redirect'

  # Dashboard
  get 'dashboard', to: 'dashboard#home'

  # Inventory
  get 'inventory', to: 'inventory#home'

  # Users and sessions
  devise_for :users, controllers: { sessions:       'users/sessions',
                                    registrations:  'users/registrations' }
  resources :users

  # Resources
  resources :plants
  resources :jars
  resources :bags
  resources :lots
  
end
