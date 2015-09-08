Rails.application.routes.draw do

  resources :accounts, except: [ :new, :edit ], defaults: { format: 'json' }

end
