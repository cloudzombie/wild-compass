Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

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
