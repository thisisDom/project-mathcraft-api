require 'rails_helper'

RSpec.describe BuildingsController, type: :controller do

  context 'GET #Buildings' do
    before(:each) do

      r1 = Resource.create(name: "wood", asset_link: 'wood.png')
      r2 = Resource.create(name: "stone", asset_link: 'stone.png')
      r3 = Resource.create(name: "gold", asset_link: 'gold.png')

      b1 = Building.create({name: 'alchemy-lab-1', asset_link: 'alchemy-lab-1.png', building_level: 1, building_class: "Alchemy Lab", offsetX: -80, offsetY: -10 })
      BuildingsResource.create({resource_id: r2.id, building_id: b1.id, quantity: 3})

      b2 = Building.create({name: 'alchemy-lab-2', asset_link: 'alchemy-lab-2.png', building_level: 2, building_class: "Alchemy Lab", offsetX: -120, offsetY: -30 })
      BuildingsResource.create({resource_id: r2.id, building_id: b2.id, quantity: 5})

      b3 = Building.create({name: 'alchemy-lab-3', asset_link: 'alchemy-lab-3.png', building_level: 3, building_class: "Alchemy Lab", offsetX: -150, offsetY: -60})
      BuildingsResource.create({resource_id: r2.id, building_id: b3.id, quantity: 10})

      b4 = Building.create({name: 'tesla-factory-1', asset_link: 'tesla-factory-1.png', building_level: 1, building_class: "Tesla Factory", offsetX: -90, offsetY: 0 })
      BuildingsResource.create({resource_id: r1.id, building_id: b4.id, quantity: 1})

      b5 = Building.create({name: 'tesla-factory-2', asset_link: 'tesla-factory-2.png', building_level: 2, building_class: "Tesla Factory", offsetX: -140, offsetY: -60 })
      BuildingsResource.create({resource_id: r1.id, building_id: b5.id, quantity: 5})

      b6 = Building.create({name: 'tesla-factory-3', asset_link: 'tesla-factory-3.png', building_level: 3, building_class: "Tesla Factory", offsetX: -160, offsetY: -70})
      BuildingsResource.create({resource_id: r1.id, building_id: b6.id, quantity: 10})

      b7 = Building.create({name: 'magic-house-1', asset_link: 'magic-house-1.png', building_level: 1, building_class: "Magic House", offsetX: -90, offsetY: -10 })

      BuildingsResource.create({resource_id: r3.id, building_id: b7.id, quantity: 2})

      b8 = Building.create({name: 'magic-house-2', asset_link: 'magic-house-2.png', building_level: 2, building_class: "Magic House", offsetX: -90, offsetY: -20 })

      BuildingsResource.create({resource_id: r3.id, building_id: b8.id, quantity: 5})

      b9 = Building.create({name: 'magic-house-3', asset_link: 'magic-house-3.png', building_level: 3, building_class: "Magic House", offsetX: -90, offsetY: -20})
      BuildingsResource.create({resource_id: r3.id, building_id: b9.id, quantity: 10})

      player = Player.create({username: "Jasper", email_address: 'test', password: 'test', avatar_asset_link: 'test' })


      PlayersResource.create({player: player, resource_id: 1, quantity: 3})
      PlayersResource.create({player: player, resource_id: 2, quantity: 3})
      PlayersResource.create({player: player, resource_id: 3, quantity: 3})

    end


    it 'responds with a status 200' do
      get :index, params: { player_id: Player.first.id}
      expect(response.status).to eq 200
    end

    xit 'responds with all available buildings to build' do
      get :index, params: { player_id: Player.first.id}
      p Building.all
      p Resource.all
      p PlayersResource.all
      p JSON.parse(response.body)
      expect(JSON.parse(response.body)).to include("buildings")
      expect(JSON.parse(response.body)['buildings'].length).to eq 3
    end
  end

end
