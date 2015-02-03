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

  get 'transaction/checkin'
  get 'transaction/checkout'

  # Resources
  resources :orders do
    member do
      get  'fulfill'
      post 'fulfill'
    end
  end

  resources :locations

  resources :bins do 
    member do
      get 'datamatrix'
      get 'label'
    end
  end

  resources :plants
  
  resources :jars do
    member do
      get  'datamatrix'
      get  'label'

      get  'scan'
      post 'scan'
    end
  end
  
  resources :bags do
    member do
      get  'datamatrix'
      get  'label'
      
      get  'reweight'
      post 'reweight'

      get  'scan'
      post 'scan'

      get 'quarantine'
      get 'recall'
    end
  end

  resources :lots do
    member do
      get 'quarantine'
      get 'recall'
    end
  end

  resources :strains
  
  resources :brands do
    member do
      get 'available'
    end
  end

  resources :containers


  # API
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      # Auth
      mount_devise_token_auth_for 'User', at: '/auth'
      resources :users

      # Resources
      resources :orders

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

          get 'quarantine'
          get 'recall'
        end
      end

      resources :lots do
        member do 
          get 'quarantine'
          get 'recall'
        end
      end

      resources :strains
      
      resources :brands do
        member do
          get 'available'
        end
      end

      resources :containers
    end
  end

end
