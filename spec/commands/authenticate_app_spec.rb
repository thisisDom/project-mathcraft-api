require 'rails_helper'

RSpec.describe AuthenticateApp, type: :command do
  it 'can set a JSON Web Token for an authorized app' do
    email, password = 'test1','test1'
    user = RegisteredApp.create({email_address: email, password: password})
    command = AuthenticateApp.call(email, password)
    expect(command.success?).to eq true
  end

  it 'returns an error if app is not authorized' do
    command = AuthenticateApp.call('test2', 'test2')
    expect(command.success?).to eq false
  end
end
