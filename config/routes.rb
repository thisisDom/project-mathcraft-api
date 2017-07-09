Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # api token authentication
  post '/authenticate', to: 'authentication#authenticate'
  # login route to check login credentials
  post '/login', to: 'sessions#login'
  # logout route to change user login status to false
  post '/logout', to: 'sessions#logout'
  # routes for the player model
  resources :players, only: [:index, :create, :show, :update, :delete]
  # routes for playing a level
  post '/levels/:id/start', to: 'playerslevels#start'
  post '/levels/:id/complete', to: 'playerslevels#complete'


end
