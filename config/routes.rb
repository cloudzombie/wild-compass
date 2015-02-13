Rails.application.routes.draw do

  # Root redirect
  root to: 'root#redirect'

  # Dashboard
  get 'dashboard', to: 'dashboard#home'

  # Inventory
  get 'inventory',                         to: 'inventory#home'
  get 'inventory/download',                to: 'inventory#download'
  get 'inventory/seeds',                   to: 'inventory/seeds#home'
  get 'inventory/seeds/download',          to: 'inventory/seeds#home'
  get 'inventory/plants',                  to: 'inventory/plants#home'
  get 'inventory/plants/download',         to: 'inventory/plants#home'
  get 'inventory/lots',                    to: 'inventory/lots#home'
  get 'inventory/lots/download',           to: 'inventory/lots#home'
  get 'inventory/bags',                    to: 'inventory/bags#home'
  get 'inventory/bags/download',           to: 'inventory/bags#home'
  get 'inventory/jars',                    to: 'inventory/jars#home'
  get 'inventory/jars/download',           to: 'inventory/jars#home'
  get 'inventory/containers',              to: 'inventory/containers#home'
  get 'inventory/containers/download',     to: 'inventory/containers#home'
  get 'inventory/plants/mothers',          to: 'inventory/plants/mothers#home'
  get 'inventory/plants/mothers/download', to: 'inventory/plants/mothers#home'
  get 'inventory/plants/clones',           to: 'inventory/plants/clones#home'
  get 'inventory/plants/clones/download',  to: 'inventory/plants/clones#home'

  # Users and sessions
  devise_for :users, controllers: { sessions:       'users/sessions',
                                    registrations:  'users/registrations' }
  
  resources :users

  devise_scope :user do
    get    'sign_in',  to: 'users/sessions#new'
    delete 'sign_out', to: 'users/sessions#destroy'
  end

  get 'transaction/checkin'
  get 'transaction/checkout'

  match 'access', to: 'access#check', via: [ :get, :post ]

  resources :transactions

  # Resources
  resources :orders do
    member do
      match 'fulfill', via: [ :get, :post ]
    end
  end

  resources :locations

  resources :seeds do
    member do
      get 'datamatrix'
      get 'label'

      match 'reweight', via: [ :get, :post ]
      match 'scan',     via: [ :get, :post ]
    end
  end

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

      match 'scan', via: [ :get, :post ]
    end
  end
  
  resources :bags do
    collection do
      get 'tested',   to: 'bags/tested#home'
      get 'archived', to: 'bags/archived#home'
    end

    member do
      get  'datamatrix'
      get  'label'
      
      match 'reweight', via: [ :get, :post ]
      match 'scan',     via: [ :get, :post ]

      get 'quarantine'
      get 'recall'
      
      get 'unquarantine'
      get 'unrecall'
    end
  end

  resources :lots do
    member do
      get 'quarantine'
      get 'recall'

      get 'unquarantine'
      get 'unrecall'
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

          get 'unquarantine'
          get 'unrecall'
        end
      end

      resources :lots do
        member do 
          get 'quarantine'
          get 'recall'

          get 'unquarantine'
          get 'unrecall'
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
