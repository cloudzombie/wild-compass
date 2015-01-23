Rails.application.routes.draw do
  
  # Root redirect
  root to: 'root#redirect'

  # Dashboard
  get 'dashboard', to: 'dashboard#home'

  # Inventory
  get 'inventory', to: 'inventory#home'
  get 'inventory/download', to: 'inventory#download'

  # Users and sessions
  devise_for :users, controllers: { sessions:       'users/sessions',
                                    registrations:  'users/registrations' }
  
  resources :users

  devise_scope :user do
    get 'sign_in', to: 'users/sessions#new'
    delete 'sign_out', to: 'users/sessions#destroy'
  end

  # Resources
  resources :orders do
    member do
      get 'datamatrix'
      get 'fulfill'
    end
  end

  resources :plants
  
  resources :jars do
    member do
      get 'datamatrix'
      get 'label'
    end
  end
  
  resources :bags do
    member do
      get 'datamatrix'
      get 'label'
    end
  end

  resources :lots
  resources :strains
  
  resources :brands do
    member { get 'available' }
  end

  resources :containers

  # API
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      # Auth
      mount_devise_token_auth_for 'User', at: '/auth'
      resources :users

      # Resources
      resources :orders do
        member { get 'datamatrix' }
      end

      resources :plants
      
      resources :jars do
        member do
          get 'datamatrix'
          get 'label'
        end
      end
      
      resources :bags do
        member do
          get 'datamatrix'
          get 'label'
        end
      end

      resources :lots
      resources :strains
      
      resources :brands do
        member { get 'available' }
      end

      resources :containers
    end
  end

end
