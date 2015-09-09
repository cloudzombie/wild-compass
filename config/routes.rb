Rails.application.routes.draw do

  # Root path
  root 'root#index'

  # Devise
  devise_for :users

  # Resources
  resources :accounts, except: [ :new, :edit ], defaults: { format: 'json' }

  namespace :account do
    resources :prefixes, except: [ :new, :edit], defaults: { format: 'json' }
    resources :transactions, except: [ :new, :edit], defaults: { format: 'json' }
  end

end
