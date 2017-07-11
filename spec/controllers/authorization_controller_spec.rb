# require 'rails_helper'
#
# RSpec.describe AuthorizationController, type: :controller do
#   before(:all) do
#     RegisteredApp.create({email_address: 'project-mathcraft', password: 'fishsticks'})
#   end
#
#   describe 'POST #authenticate' do
#     context 'Authorized' do
#       before(:each) do
#         post :authenticate, params: {email_address: 'project-mathcraft', password: 'fishsticks' }
#       end
#       it 'responds with status code 200 if authorized' do
#         expect(response.status).to eq 200
#       end
#       it 'responds with API token' do
#         expect(response.content_type).to eq "application/json"
#         expect(response.body).to include('auth_token')
#       end
#     end
#
#     context 'Not Authorized' do
#       it 'responds with 401 if no credentials are present' do
#         post :authenticate
#         expect(response.status).to eq 401
#         expect(response.body).to include("user_authentication")
#       end
#     end
#   end
#
# end
