Rails.application.routes.draw do

  resources :weights

  concern :recallable do
    member do
      get 'recall'
      get 'unrecall'
    end
  end

  concern :quarantineable do
    member do
      get 'quarantine'
      get 'unquarantine'
    end
  end

  concern :releaseable do
    member do
      get 'release'
      get 'unrelease'
    end
  end

  concern :labelable do
    member do
      get 'label'
    end
  end

  concern :encodable do
    member do
      get 'datamatrix'
    end
  end

  concern :returnable do
    member do
      get 'perform_return'
    end
  end

  concern :reweightable do
    member do
      match 'reweight', via: [ :get, :post ]
    end
  end

  concern :scannable do
    member do
      match 'scan', via: [ :get, :post ]
    end
  end

  get 'plants/report', to: 'plants#report'
  get 'lots/report',   to: 'lots#report'

  # Root redirect
  root to: 'root#redirect'

  # Dashboard
  get 'dashboard', to: 'dashboard#home'

  # Inventory
  match 'inventory',                         to: 'inventory#home',                via: [:get, :post]
  match 'inventory/download',                to: 'inventory#download',            via: [:get, :post]
  match 'inventory/seeds',                   to: 'inventory/seeds#home',          via: [:get, :post]
  match 'inventory/seeds/download',          to: 'inventory/seeds#home',          via: [:get, :post]
  match 'inventory/plants',                  to: 'inventory/plants#home',         via: [:get, :post]
  match 'inventory/plants/download',         to: 'inventory/plants#home',         via: [:get, :post]
  match 'inventory/lots',                    to: 'inventory/lots#home',           via: [:get, :post]
  match 'inventory/lots/download',           to: 'inventory/lots#home',           via: [:get, :post]
  match 'inventory/bags',                    to: 'inventory/bags#home',           via: [:get, :post]
  match 'inventory/bags/download',           to: 'inventory/bags#home',           via: [:get, :post]
  match 'inventory/jars',                    to: 'inventory/jars#home',           via: [:get, :post]
  match 'inventory/jars/download',           to: 'inventory/jars#home',           via: [:get, :post]
  match 'inventory/containers',              to: 'inventory/containers#home',     via: [:get, :post]
  match 'inventory/containers/download',     to: 'inventory/containers#home',     via: [:get, :post]
  match 'inventory/plants/mothers',          to: 'inventory/plants/mothers#home', via: [:get, :post]
  match 'inventory/plants/mothers/download', to: 'inventory/plants/mothers#home', via: [:get, :post]
  match 'inventory/plants/clones',           to: 'inventory/plants/clones#home',  via: [:get, :post]
  match 'inventory/plants/clones/download',  to: 'inventory/plants/clones#home',  via: [:get, :post]
  match 'inventory/plants/babies',           to: 'inventory/plants/babies#home',  via: [:get, :post]
  match 'inventory/plants/babies/download',  to: 'inventory/plants/babies#home',  via: [:get, :post]

  # Users and sessions
  devise_for :users, controllers: { sessions:      'users/sessions',
                                    registrations: 'users/registrations' }
  
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

  namespace :process do
    resources :fulfills, only: [ :new, :create ]
    resources :relots, only: [ :new, :create ]
    resources :reweights, only: [ :new, :create ]
    resources :scales, only: [ :new, :create ]
  end

  resources :locations

  resources :seeds, concerns: [ :labelable, :encodable, :reweightable, :scannable ] do
    resources :weights
  end

  resources :bins, concerns: [ :labelable, :encodable ]

  resources :plants, concerns: [ :labelable ] do
    resources :weights
  end
  
  resources :jars, concerns: [ :labelable, :encodable, :scannable, :returnable ] do
    resources :weights
    member do
      get 'destruction'
      get 'send_to_lab'
    end
  end
  
  resources :bags, concerns: [ :recallable, :quarantineable, :labelable, :encodable, :reweightable, :scannable ] do
    resources :weights
    collection do
      get 'tested',   to: 'bags/tested#home'
      get 'archived', to: 'bags/archived#home'
      get 'suggestions'
    end

    member do
      get 'relot'

      get 'destruction'
      get 'send_to_lab'
    end
  end

  resources :lots, concerns: [ :recallable, :quarantineable, :releaseable ] do
    resources :weights
    member do
      get 'relot'
    end
  end

  resources :strains
  
  resources :brands do
    member do
      get 'available'
    end
  end

  # Containers

  resources :containers do 
    resources :weights
  end

  # Utility

  match :scan,  to: 'scan#scan',   via: [ :get, :post ]
  match :scale, to: 'scale#scale', via: [ :get, :post ]

  # Logging
  
  namespace :logger do
    post 'info'
    post 'debug'
    post 'warn'
    post 'error'
    post 'fatal'
    post 'unknown'
  end



  ######################################################
  ######################################################
  ### API
  ######################################################
  ######################################################

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      # Auth
      mount_devise_token_auth_for 'User', at: '/auth'
      resources :users

      # Resources
      resources :orders

      resources :plants
      
      resources :jars, concerns: [ :labelable, :encodable, :returnable ]
      
      resources :bags, concerns: [ :recallable, :quarantineable, :labelable, :encodable ]

      resources :lots, concerns: [ :recallable, :quarantineable ]

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
