Rails.application.routes.draw do

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

  resources :plants do
    member do
      get 'label'
    end
  end
  
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
      get 'suggestions'
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

      get 'relot'

      get 'destruction'
      get 'send_to_lab'
    end
  end

  resources :lots do
    member do
      get 'release'

      get 'quarantine'
      get 'recall'

      get 'unquarantine'
      get 'unrecall'

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

  resources :containers

  # Utility

  match :scan,  to: 'scan#scan',   via: [ :get, :post ]
  match :scale, to: 'scale#scale', via: [ :get, :post ]



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
