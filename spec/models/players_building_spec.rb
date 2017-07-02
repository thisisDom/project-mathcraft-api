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
    let(:playersbuilding) { PlayersBuilding.create({ player: player,
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
end
