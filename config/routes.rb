Rails.application.routes.draw do

  root 'root#redirect'

  resources :accounts, except: [ :new, :edit ], defaults: { format: 'json' }

end
