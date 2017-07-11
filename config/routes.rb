Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # api token authentication
  post '/authenticate', to: 'authorization#authenticate'
  # login route to check login credentials
  post '/login', to: 'sessions#login'
  # logout route to change user login status to false
  post '/logout', to: 'sessions#logout'
  # routes for the player model
  resources :players, only: [:index, :create, :show, :update, :delete] do
    resources :playerslevels, only: [:index, :create, :update], path_names: { create: 'start', update: 'complete' }
    resources :playersbuildings, only: [:index, :create, :delete]
    resources :playersresources, only: [:index, :show]
  end

  post '/players/:player_id/playersbuildings/:id/move', to: 'playersbuildings#move'
  post '/players/:player_id/playersbuildings/:id/upgrade', to: 'playersbuildings#upgrade'

  resources :levels, only: [:index, :show]
  resources :buildings, only: [:index, :show]
  resources :resources, only: [:index, :show]

end
