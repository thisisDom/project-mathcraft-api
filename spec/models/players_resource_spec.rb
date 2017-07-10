require 'rails_helper'

RSpec.describe PlayersResource, type: :model do
  describe 'attributes' do
    let(:playersresource) { PlayersResource.new }

    it 'has a quantity' do
      playersresource.quantity = 20
      expect(playersresource.quantity).to eq 20
    end

    it 'has a resource id' do
      playersresource.player_id = 1
      expect(playersresource.player_id).to eq 1
    end

    it 'has a player_id' do
      playersresource.resource_id = 1
      expect(playersresource.resource_id).to eq 1
    end
  end

  describe 'validations' do
    let(:resource) { Resource.create({ name: 'wood', asset_link: "/path/to/asset" }) }
    let(:player) { Player.create({ username: 'test',
                                   email_address: 'test@test.com',
                                   password: 'test',
                                   experience: 0,
                                   avatar_asset_link: '/path/to/asset/link.jpg'}) }
    context 'quantity' do
      it 'is greater than or equal to 0' do
        playersresource = PlayersResource.create({ resource: resource,
                                                   player: player,
                                                   quantity: -1
                                                  })
        expect(playersresource.errors.full_messages.length).to eq 1
      end
    end
  end
  describe 'associations' do
    let(:resource) { Resource.create({ name: 'wood', asset_link: "/path/to/asset" }) }
    let(:player) { Player.create({username: 'test',
                                  email_address: 'test@test.com',
                                  password: 'test',
                                  experience: 0,
                                  avatar_asset_link: '/path/to/asset/link.jpg'}) }
    let(:playersresource) { PlayersResource.create({ resource: resource,
                                                     player: player,
                                                     quantity: 10
                                                    }) }

    it 'belongs to a resource' do
      expect(playersresource.resource).to be_a(Resource)
    end

    it 'belongs to a player' do
      expect(playersresource.player).to be_a(Player)
    end

  end
end
