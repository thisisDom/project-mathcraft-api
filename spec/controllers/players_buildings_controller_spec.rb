require 'rails_helper'

RSpec.describe PlayersBuildingsController, type: :controller do
  before(:each) do
    max_level = 15
    while Experience.count < max_level
      Experience.create({ level: Experience.count, experience_needed: Experience.count ** 3 })
    end
    player = Player.create({username: "Jasper", email_address: 'test', password: 'test', avatar_asset_link: 'test' })
    resource = Resource.create({ name: 'wood', asset_link: "/path/to/asset" })
    building = Building.create({name: 'alchemy-lab-1', asset_link: 'alchemy-lab-1.png', building_level: 1, building_class: "Alchemy Lab", offsetX: -80, offsetY: -10 })
    PlayersResource.create({player: player, resource: resource, quantity: 20})
    BuildingsResource.create({resource: resource, building: building, quantity: 5})
    PlayersBuilding.create({building: building, player: player, location: 2})
  end

  context "GET #index" do
    it 'responds with status 200' do
      get :index,  params: { data: { player_id: Player.first.id} }
      expect(response.status).to eq 200
    end

    it 'responds with a collection of buildings' do
      get :index,  params: { data: { player_id: Player.first.id} }
      expect(JSON.parse(response.body)).to include('buildings')
    end
  end

  context 'POST #create' do
    it 'responds with status 200' do
      post :create, params: { data: { player_id: Player.first.id, building_name: Building.first.name, location: 4 }}
      expect(response.status).to eq 200
    end

    it 'responds with a player' do
      post :create, params: { data: { player_id: Player.first.id, building_name: Building.first.name, location: 4 }}
      expect(JSON.parse(response.body)).to include('player')
    end

    it 'changes the players resource quantoty' do
      post :create, params: { data: { player_id: Player.first.id, building_name: Building.first.name, location: 4 }}
      expect(JSON.parse(response.body)['player']['resources'][0]['quantity']).to eq 15
    end

    it 'responds with an error if not enough resources' do
      id = Player.first.players_resources.destroy_all
      post :create, params: { data: { player_id: Player.first.id, building_name: Building.first.name, location: 4 }}
      expect(JSON.parse(response.body)).to include('errors')
    end

  end

  context 'POST upgrade' do
    it 'responds with status 200' do
      post :create, params: { data: { player_id: Player.first.id, building_name: Building.first.name, location: 4 }}
      pb = Player.first.players_buildings[0]
      b1 = Building.create({name: 'alchemy-lab-2', asset_link: 'alchemy-lab-2.png', building_level: 2, building_class: "Alchemy Lab", offsetX: -80, offsetY: -10 })
      BuildingsResource.create({resource_id: 2, building_id: b1.id, quantity: 1})
      post :upgrade, params: { data: { player_id: Player.first.id, building_name: b1.id, players_building_id: pb.id, location: pb.location  }}
      expect(response.status).to eq 200
    end

    it 'responds with a player' do
      post :create, params: { data: { player_id: Player.first.id, building_name: Building.first.name, location: 4 }}
      pb = Player.first.players_buildings[0]
      b1 = Building.create({name: 'alchemy-lab-3', asset_link: 'alchemy-lab-3.png', building_level: 2, building_class: "Alchemy Lab", offsetX: -80, offsetY: -10 })
      BuildingsResource.create({resource_id: Resource.first.id, building_id: b1.id, quantity: 1})
      post :upgrade, params: { data: { player_id: Player.first.id, building_name: b1.name, players_building_id: pb.id, location: pb.location  }}
      expect(JSON.parse(response.body)).to include('player')
    end

    it 'responds with an error if not enough resources' do
      post :create, params: { data: { player_id: Player.first.id, building_name: Building.first.name, location: 4 }}
      pb = Player.first.players_buildings[0]
      b1 = Building.create({name: 'alchemy-lab-3', asset_link: 'alchemy-lab-3.png', building_level: 2, building_class: "Alchemy Lab", offsetX: -80, offsetY: -10 })
        BuildingsResource.destroy_all
      BuildingsResource.create({resource_id: Resource.first.id, building_id: b1.id, quantity: 300})
      post :upgrade, params: { data: { player_id: Player.first.id, building_name: b1.id, players_building_id: pb.id, location: pb.location }}
      expect(JSON.parse(response.body)).to include('errors')
    end
  end
end
