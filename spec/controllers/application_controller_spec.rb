require 'rails_helper'

RSpec.xdescribe ApplicationController, type: :controller do
  before(:all) do
    RegisteredApp.create({email_address: 'project-mathcraft', password: 'fishsticks'})
    post :authenticate, params: { email_address: 'project-mathcraft', password: 'fishsticks' }
    token = response.body
    request.headers['Authentication'] = "Basic #{token}"
  end
end
