Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # api token authentication
  post '/authenticate', to: 'authentication#authenticate'

end
