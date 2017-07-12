require 'rails_helper'

RSpec.describe PlayersBuilding, type: :model do
  describe 'attributes' do
    let(:playerbuilding) { PlayersBuilding.new }

    it 'has a location' do
      playerbuilding.location = ["0","0"]
      expect(playerbuilding.location).to eq ["0","0"]
    end

    it 'has a building id' do
      playerbuilding.building_id = 1
      expect(playerbuilding.building_id).to eq 1
    end

    it 'has a player_id' do
      playerbuilding.player_id = 1
      expect(playerbuilding.player_id).to eq 1
    end
  end

  describe 'validations' do
    context 'location' do
      let(:player) { Player.create({username: 'test',
                                    email_address: 'test@test.com',
                                    password: 'test',
                                    experience: 0,
                                    avatar_asset_link: '/path/to/asset/link.jpg'}) }
      let(:building) { Building.create({  asset_link: "/path/to/asset",
                                          width: 1,
                                          height: 1,
                                          building_class: 'resource',
                                          building_level: 1,
                                        }) }
      it 'is present' do
        playersbuilding = PlayersBuilding.create({ player: player,
                                                  building: building,
                                                 })


        expect(playersbuilding.errors.full_messages.length).to eq 1
      end
      it 'is unique' do
        PlayersBuilding.create({ player: player,
                                 building: building,
                                 location: [0,0]
                               })
        playersbuilding = PlayersBuilding.create({ player: player,
                                                   building: building,
                                                   location: [0,0]
                                                 })
        expect(playersbuilding.errors.full_messages.length).to eq 1
      end
    end
  end

  describe 'associations' do
    let(:player) { Player.create({username: 'test',
                                  email_address: 'test@test.com',
                                  password: 'test',
                                  experience: 0,
                                  avatar_asset_link: '/path/to/asset/link.jpg'}) }
    let(:building) { Building.create({  asset_link: "/path/to/asset",
                                        width: 1,
                                        height: 1,
                                        building_class: 'resource',
                                        building_level: 1,
                                      }) }
    let(:playersbuilding) { PlayersBuilding.new({ player: player,
                                                     building: building,
                                                     location: [0,0]
                                                   }) }

    it 'belongs to a player' do
      expect(playersbuilding.player).to be_a(Player)
    end

    it 'belongs to a building' do
      expect(playersbuilding.building).to be_a(Building)
    end

  end

  describe 'methods' do
    let(:player) { Player.create({username: 'test',
                                  email_address: 'test@test.com',
                                  password: 'test',
                                  experience: 0,
                                  avatar_asset_link: '/path/to/avatar.jpg'}) }
    let(:building) { Building.create({  asset_link: '/path/to/asset.jpg',
                                        width: 1,
                                        height: 1,
                                        building_class: 'resource',
                                        building_level: 1,
                                      }) }
    let(:resource) { Resource.create({ name: 'wood', asset_link: '/path/to/asset.jpg'})}
    let(:players_building) { PlayersBuilding.new({ player: player,
                                                     building: building,
                                                     location: [0,0]
                                                   }) }
    context 'can check if a player has enough materials to build/upgrade a building' do
      it 'returns true if player has enough materials' do
        BuildingsResource.create({ building: building,
                                   resource: resource,
                                   quantity: 5
                                  })
        PlayersResource.create({ player: player, resource: resource, quantity: 10 })
        expect(players_building.buildable?).to eq true
      end
      it 'returns false if the player does not have enough materials' do
        BuildingsResource.create({ building: building,
                                   resource: resource,
                                   quantity: 5
                                  })
        PlayersResource.create({ player: player, resource: resource, quantity: 3 })
        expect(players_building.buildable?).to eq false
      end

    end

    context 'can build a building' do
      it 'returns true if building is built' do
        BuildingsResource.create({ building: building,
                                   resource: resource,
                                   quantity: 5
                                  })
        player_resource = PlayersResource.create({ player: player, resource: resource, quantity: 10 })
        expect(players_building.build).to eq true
        expect(PlayersResource.find_by(id: player_resource.id).quantity).to eq 5
      end

      it 'returns false if building cannot be built' do
        BuildingsResource.create({ building: building,
                                   resource: resource,
                                   quantity: 5
                                  })
        PlayersResource.create({ player: player, resource: resource, quantity: 3 })
        expect(players_building.build).to eq false
      end
    end

    context 'can upgrade a building' do
      it 'it returns true if building cannot be built' do
        BuildingsResource.create({ building: building,
                                   resource: resource,
                                   quantity: 5
                                  })
        player_resource = PlayersResource.create({ player: player, resource: resource, quantity: 10 })
        players_building.build

        expect(players_building.building).to eq building

        new_building = Building.create({  asset_link: '/path/to/asset.jpg',
                                          width: 1,
                                          height: 1,
                                          building_class: 'resource',
                                          building_level: 1
                                        })

        BuildingsResource.create({ building: new_building,
                                   resource: resource,
                                   quantity: 5
                                  })


        expect(players_building.upgrade(new_building)).to eq true
        expect(players_building.building).to eq new_building
        expect(PlayersResource.find_by(id: player_resource.id).quantity).to eq 0
      end

      it 'returns false if building cannot be built' do
        BuildingsResource.create({ building: building,
                                   resource: resource,
                                   quantity: 5
                                  })
        player_resource = PlayersResource.create({ player: player, resource: resource, quantity: 5 })

        PlayersResource.create({ player: player, resource: resource, quantity: 5 })
        expect(players_building.build).to eq true

        new_building = Building.create({  asset_link: '/path/to/asset.jpg',
                                          width: 1,
                                          height: 1,
                                          building_class: 'resource',
                                          building_level: 1
                                        })

        BuildingsResource.create({ building: new_building,
                                   resource: resource,
                                   quantity: 5
                                  })


        expect(players_building.upgrade(new_building)).to eq false
        expect(players_building.building).to eq building
      end
    end
  end
end
