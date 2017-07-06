require 'rails_helper'

RSpec.describe AuthorizeApiRequest, type: :command do
  describe 'api request' do
      context 'authorized if' do
        it 'has a valid token' do
          RegisteredApp.create({email_address: 'test', password: 'test'})
          token = AuthenticateApp.call('test', 'test').result
          response = AuthorizeApiRequest.call({ 'Authorization' => "Basic #{token}" })
          expect(response).to be_truthy
        end
      end

      context 'not authorized if' do
        it 'token is not present' do
          RegisteredApp.create({email_address: 'test', password: 'test'})
          token = AuthenticateApp.call('test', 'test').result
          response = AuthorizeApiRequest.call()
          expect(response.errors[:token][0]).to eq 'Missing Token'
        end

        it 'token is invalid' do
          token = 'test'
          response = AuthorizeApiRequest.call({ 'Authorization' => "Basic #{token}" })
          expect(response.errors[:token][0]).to eq 'Invalid Token'
        end
      end
    end
end
