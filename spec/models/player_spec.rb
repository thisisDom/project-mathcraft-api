require 'rails_helper'

RSpec.describe Player, type: :model do
  describe 'attributes' do
    context 'reading and writing' do
      let(:player) { Player.new }

      it 'has a username' do
        player.username = 'test'
        expect(player.username).to eq 'test'
      end

      it 'has a email address' do
        player.email_address = 'test@test.com'
        expect(player.email_address).to eq 'test@test.com'
      end

      it 'has a password' do
        player.password = 'test'
        expect(player.password).to eq 'test'
      end

      it 'has experience' do
        player.experience = 10
        expect(player.experience).to eq 10
      end

      it 'has an avatar asset link' do
        player.avatar_asset_link = '/path/to/asset/link.jpg'
        expect(player.avatar_asset_link).to eq '/path/to/asset/link.jpg'
      end

      it 'has a level' do
        max_level = 15
        while Experience.count < max_level
          Experience.create({ level: Experience.count, experience_needed: Experience.count ** 3 })
        end
        expect(player.level).to eq 0
        player.experience = 4
        expect(player.level).to eq 1
        player.experience = 10
        expect(player.level).to eq 2
        player.experience = 27
        expect(player.level).to eq 3
        player.experience = 100
        expect(player.level).to eq 4
      end

    end

    context 'validations' do

      context 'username' do
        it 'has a username' do
          player = Player.create( {  email_address: 'test1@test.com',
                                      password: 'test',
                                      experience: 0,
                                      avatar_asset_link: '/path/to/asset/link.jpg'
                                    })
          expect(player.errors.full_messages.length).to eq 1
        end

        it 'has a unique username' do
          Player.create( { username: 'test',
                            email_address: 'test@test.com',
                            password: 'test',
                            experience: 0,
                            avatar_asset_link: '/path/to/asset/link.jpg'
                          })
          player = Player.create( { username: 'test',
                                      email_address: 'test1@test.com',
                                      password: 'test',
                                      experience: 0,
                                      avatar_asset_link: '/path/to/asset/link.jpg'
                                    })
          expect(player.errors.full_messages.length).to eq 1
        end
      end

      context 'email_address' do
        it 'has a email address' do
          player = Player.create( {   username: 'test1',
                                      password: 'test',
                                      experience: 0,
                                      avatar_asset_link: '/path/to/asset/link.jpg'
                                    })
          expect(player.errors.full_messages.length).to eq 1
        end

        it 'has a unique email address' do
          Player.create( { username: 'test',
                            email_address: 'test@test.com',
                            password: 'test',
                            experience: 0,
                            avatar_asset_link: '/path/to/asset/link.jpg'
                          })
          player = Player.create( { username: 'test1',
                                      email_address: 'test@test.com',
                                      password: 'test',
                                      experience: 0,
                                      avatar_asset_link: '/path/to/asset/link.jpg'
                                    })
          expect(player.errors.full_messages.length).to eq 1
        end
      end

      context 'password' do
        it 'has a password' do
          player = Player.create( { username: 'test1',
                                    email_address: 'test@test.com',
                                    experience: 0,
                                    avatar_asset_link: '/path/to/asset/link.jpg'
                                  })
          expect(player.errors.full_messages.length).to eq 1
        end
      end

      context 'experience' do
        it 'experience is greater than or equal to 0' do
          player = Player.create( { username: 'test1',
                                    email_address: 'test@test.com',
                                    password: 'test',
                                    experience: -1,
                                    avatar_asset_link: '/path/to/asset/link.jpg'
                                  })
          expect(player.errors.full_messages.length).to eq 1
        end
      end

      context 'avatar' do
        it 'has an avatar' do
          player = Player.create( { username: 'test1',
                                    email_address: 'test@test.com',
                                    password: 'test',
                                    experience: 0,
                                  })
          expect(player.errors.full_messages.length).to eq 1
        end
      end

    end

    context 'associations' do
      it 'has many buildings' do
        player = Player.create({ username: 'test',
                                 email_address: 'test@test.com',
                                 password: 'test',
                                 experience: 0,
                                 avatar_asset_link: '/path/to/asset/link.jpg'
                                })

        building = Building.create({ asset_link: "/path/to/asset",
                                     offsetX: 1,
                                     offsetY: 1,
                                     building_class: 'resource',
                                     building_level: 1,
                                    })

        PlayersBuilding.create({ player: player,
                                 building: building,
                                 location: 1
                               })

        expect(player.buildings.length).to eq 1
      end

      it 'has many resources' do

          player = Player.create({ username: 'test',
                                   email_address: 'test@test.com',
                                   password: 'test',
                                   experience: 0,
                                   avatar_asset_link: '/path/to/asset/link.jpg'
                                  })

          resource = Resource.create({ name: 'wood', asset_link: '/path/to/asset'})

          PlayersResource.create({ player: player,
                                   resource: resource,
                                   quantity: 20
                                  })

          expect(player.resources.length).to eq 1
          player.serializable_hash(methods: [:buildings, :resources])
        end
    end
  end
  describe 'methods' do
    let(:player) { Player.new }

    it 'can level up a player' do
      player.experience = 0
      player.level_up(10)
      expect(player.experience).to eq 10
    end
  end
end
