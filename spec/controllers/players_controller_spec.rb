require 'rails_helper'

RSpec.describe PlayersController, type: :controller do
  before(:all) do
    max_level = 15
    while Experience.count < max_level
      Experience.create({ level: Experience.count, experience_needed: Experience.count ** 3 })
    end
  end
  context 'POST #create' do
    it 'responds with status code 201' do
      post :create, params: { player: { email_address: 'test', password: 'test', username: 'test', avatar_asset_link: 'test/test/test.test' } }
      expect(response.status).to eq 201
    end

    it 'responds with a json' do
      post :create, params: { player: { email_address: 'test', password: 'test', username: 'test', avatar_asset_link: 'test/test/test.test' } }
      expect(response.content_type).to eq "application/json"
    end

    it 'responds with a player' do
      post :create, params: { player: { email_address: 'test', password: 'test', username: 'test', avatar_asset_link: 'test/test/test.test' } }
      expect(response.body).to include("player")
    end
  end

  context 'GET #show' do
    it 'responds with status code 200' do
      post :create, params: { player: { email_address: 'test', password: 'test', username: 'test', avatar_asset_link: 'test/test/test.test' } }
      post :show, params: { id: JSON.parse(response.body)["player"]["id"] }
      expect(response.status).to eq 200
    end

    it 'responds with a json' do
      post :create, params: { player: { email_address: 'test', password: 'test', username: 'test', avatar_asset_link: 'test/test/test.test' } }
      post :show, params: { id: JSON.parse(response.body)["player"]["id"] }
      expect(response.content_type).to eq "application/json"
    end

    it 'responds with a player' do
      post :create, params: { player: { email_address: 'test', password: 'test', username: 'test', avatar_asset_link: 'test/test/test.test' } }
      id = JSON.parse(response.body)["player"]["id"]
      post :show, params: { id: id }
      expect(response.body).to include("player")
      p JSON.parse(response.body)
      expect(JSON.parse(response.body)["player"]["id"]).to eq id
    end

    it 'responds with status code 404 if no player can\'t be found' do
      post :show, params: { id: 400 }
      expect(response.status).to eq 404
    end
  end

  context 'DELETE #destroy' do
    it 'deletes a player' do
      post :create, params: { player: { email_address: 'test', password: 'test', username: 'test', avatar_asset_link: 'test/test/test.test' } }
      id = JSON.parse(response.body)["player"]["id"]
      post :show, params: { id: id }
      expect(response.body).to include("player")
      delete :destroy, params: { id: id }
      post :show, params: { id: 400 }
      expect(response.status).to eq 404
    end
  end
end
