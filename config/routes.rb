Rails.application.routes.draw do
  
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

  # Users
  namespace :user do
    resources :groups
    # resources :roles
    # namespace :group do
    # resources :roles  
    # end
  end

  # Resources
  resources :orders
  resources :plants
  resources :jars
  resources :bags
  resources :lots
  
end
