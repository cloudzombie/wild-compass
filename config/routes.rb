Rails.application.routes.draw do
  
  # Root redirect
  root to: 'root#redirect'

  # Dashboard
  get 'dashboard', to: 'dashboard#home'

  # Inventory
  get 'inventory', to: 'inventory#home'
  get 'inventory/download', to: 'inventory#download'

  # Users and sessions
  resources :users

  devise_scope :user do
    get 'sign_in', to: 'users/sessions#new'
    delete 'sign_out', to: 'users/sessions#destroy'
  end

  devise_for :users, controllers: { sessions:       'users/sessions',
                                    registrations:  'users/registrations' }

  # Users
  # namespace :user do
  #   resources :groups
  #   # resources :roles
  #   # namespace :group do
  #   # resources :roles  
  #   # end
  # end

  # Resources
  resources :orders
  resources :plants

  resources :jars do
    member { get 'datamatrix' }
  end
  
  resources :bags
  resources :lots
  resources :strains
  
end
