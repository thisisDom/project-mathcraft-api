require 'rails_helper'

RSpec.describe RegisteredApp, type: :model do

  describe 'attributes' do
    let(:registeredapp) { RegisteredApp.new}
    it 'has a email address' do
      registeredapp.email_address = 'test@test.com'
      expect(registeredapp.email_address).to eq 'test@test.com'
    end

    it 'has a password' do
      registeredapp.password = 'test'
      expect(registeredapp.password).to eq 'test'
    end
  end

  describe 'validations' do
    context 'email' do
      it 'has a email address' do
        registeredapp = RegisteredApp.create({ password: 'test' })
        expect(registeredapp.errors.full_messages.length).to eq 1
      end

      it 'has a unique email address' do
        RegisteredApp.create({ email_address: 'test', password: 'test' })
        registeredapp = RegisteredApp.create({ email_address: 'test', password: 'test' })
        expect(registeredapp.errors.full_messages.length).to eq 1
      end
    end
  end
end
