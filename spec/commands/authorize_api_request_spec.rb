require 'rails_helper'

RSpec.describe AuthorizeApiRequest, type: :command do
    it 'authorizes api request' do
      RegisteredApp.create({email_address: 'test', password: 'test'})
      token = AuthenticateApp.call('test', 'test').result
      response = AuthorizeApiRequest.call({ 'Authorization' => "Basic #{token}" })
      expect(response).to be_truthy
    end
end
