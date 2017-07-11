# require 'rails_helper'

# RSpec.describe ApplicationController, type: :controller do
#   before(:all) do
#     RegisteredApp.create({email_address: 'project-mathcraft', password: 'fishsticks'})
#   end
#
#   describe 'authorization of requests' do
#     context 'authorized' do
#       it 'responds with the registered app that made the request' do
#         post :authenticate, params: { email_address: 'project-mathcraft', password: 'fishsticks' }
#         token = response.body
#         request.headers['Authentication'] = "Basic #{token}"
#       end
#     end
#   end
# end
