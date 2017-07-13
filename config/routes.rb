Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # api token authentication
  # post '/authenticate', to: 'authorization#authenticate'
  # login route to check login credentials
  post '/login', to: 'sessions#login'
  # logout route to change user login status to false
  post '/logout', to: 'sessions#logout'
  # routes for the player model
  resources :players, except: [:new, :edit]

  resources :playersresources, controller: 'players_resources', only: [:index, :show]

  resources :playersbuildings, controller: 'players_buildings', only: [:index, :create, :destroy]

  post '/playersbuildings/move', to: 'players_buildings#move'
  post '/playersbuildings/upgrade', to: 'players_buildings#upgrade'

  post '/playerslevels/start', to: 'players_levels#start'
  post '/playerslevels/complete', to: 'players_levels#complete'


  resources :levels, only: [:index, :show]
  resources :buildings, only: [:index, :show]
  resources :resources, only: [:index, :show]

  #route to get questions
  get '/generate', to: 'questions#generate'

end
