Rails.application.routes.draw do
  # Root redirect
  root to: 'root#redirect'

  # Dashboard
  get 'dashboard/home'

  # Users and sessions
  devise_for :users, controllers: { sessions: 'users/sessions',
                                    registrations: 'users/registrations' }
  resources :users

  # Resources
  resources :pots
  resources :bags
  resources :lots
end
